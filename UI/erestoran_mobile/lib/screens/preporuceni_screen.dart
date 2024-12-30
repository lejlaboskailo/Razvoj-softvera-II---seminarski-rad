import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/providers/meni_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreporucenaJelaScreen extends StatefulWidget {
  final int korisnikId;

  PreporucenaJelaScreen({required this.korisnikId});

  @override
  _PreporucenaJelaScreenState createState() => _PreporucenaJelaScreenState();
}

class _PreporucenaJelaScreenState extends State<PreporucenaJelaScreen> {
  late Future<List<Jelo>> futureJela;

  @override
  void initState() {
    super.initState();
    futureJela = context.read<MeniProvider>().getPreporucenaJela(widget.korisnikId); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preporučena Jela'),
      ),
      body: FutureBuilder<List<Jelo>>(
        future: futureJela,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Došlo je do greške: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nema preporučenih jela.'));
          } else {
            List<Jelo> jela = snapshot.data!;
            return ListView.builder(
              itemCount: jela.length,
              itemBuilder: (context, index) {
                Jelo jelo = jela[index];
                return ListTile(
                  title: Text(jelo.naziv.toString()),
                  subtitle: Text(jelo.opis.toString()),
                  trailing: Text('€${jelo.cijena.toString()}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
