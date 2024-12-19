import 'package:erestoran_admin/providers/uplata_po_korisniku_provider.dart';
import 'package:flutter/material.dart';
import 'package:erestoran_admin/models/uplata_po_korisniku.dart';

class UplatePoKorisnikuReport extends StatefulWidget {
  @override
  _UplatePoKorisnikuReportState createState() =>
      _UplatePoKorisnikuReportState();
}

class _UplatePoKorisnikuReportState extends State<UplatePoKorisnikuReport> {
  late UplatePoKorisnikuProvider _uplatePoKorisnikuProvider;
  late Future<List<UplataPoKorisniku>> _uplateFuture;

  @override
  void initState() {
    super.initState();
    _uplatePoKorisnikuProvider = UplatePoKorisnikuProvider();
    _uplateFuture = _uplatePoKorisnikuProvider.fetchUplate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uplate po korisniku"),
      ),
      body: FutureBuilder<List<UplataPoKorisniku>>(
        future: _uplateFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Greška: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nema podataka za prikaz."));
          } else {
            List<UplataPoKorisniku> uplate = snapshot.data!;
            return ListView.builder(
              itemCount: uplate.length,
              itemBuilder: (context, index) {
                final uplata = uplate[index];
                return ListTile(
                  title: Text("${uplata.imeKorisnika} ${uplata.prezimeKorisnika}"),
                  subtitle: Text(
                    "Iznos: ${uplata.iznos} | Datum: ${uplata.datumTransakcije}",
                  ),
                  trailing: Text(uplata.nacinPlacanja ?? "Nepoznato"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
