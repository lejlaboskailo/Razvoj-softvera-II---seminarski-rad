import 'dart:convert';
import 'package:erestoran_mobile/models/dojmovi.dart';
import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/models/search_result.dart';
import 'package:erestoran_mobile/providers/dojmovi_provider.dart';
import 'package:erestoran_mobile/providers/jelo_provider.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecenzijaScreen extends StatefulWidget {
  const RecenzijaScreen({Key? key}) : super(key: key);

  @override
  State<RecenzijaScreen> createState() => _RecenzijaScreen();
}

class _RecenzijaScreen extends State<RecenzijaScreen> {
  late DojmoviProvider _dojmoviProvider;
  late ProductProvider _jeloProvider;
  late KorisnikProvider _korisnikProvider;

  SearchResult<Dojmovi>? stavkeResult;
  Map<String, Jelo> jeloMap = {};
  Map<String, String> korisnikMap = {};

  final TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dojmoviProvider = context.read<DojmoviProvider>();
    _jeloProvider = context.read<ProductProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      stavkeResult = await _dojmoviProvider.get();
      var jeloResult = await _jeloProvider.get();
      var korisnikResult = await _korisnikProvider.get();

      if (jeloResult?.result != null && korisnikResult?.result != null) {
        setState(() {
          jeloMap = {
            for (var jelo in jeloResult!.result) jelo.jeloId.toString(): jelo
          };
          korisnikMap = {
            for (var k in korisnikResult!.result) k.id.toString(): k.ime ?? ''
          };
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Widget _buildStars(double ocjena) {
    int fullStars = ocjena.floor();
    bool hasHalf = (ocjena - fullStars) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.orange, size: 16);
        } else if (index == fullStars && hasHalf) {
          return const Icon(Icons.star_half, color: Colors.orange, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.orange, size: 16);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Recenzije korisnika"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: stavkeResult == null
            ? const Center(child: CircularProgressIndicator())
            : stavkeResult!.result.isEmpty
                ? const Center(child: Text("Nema recenzija za prikaz"))
                : ListView.builder(
                    itemCount: stavkeResult!.result.length,
                    itemBuilder: (context, index) {
                      final d = stavkeResult!.result[index];
                      final jelo = jeloMap[d.jeloId.toString()];
                      final korisnik = korisnikMap[d.korisnikId.toString()] ?? 'Nepoznato';
                      final datum = d.datumRecenzije != null
                          ? DateFormat('dd.MM.yyyy HH:mm').format(d.datumRecenzije!)
                          : '';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (jelo?.slika != null && jelo!.slika!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    base64Decode(jelo.slika!),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(child: Text('Nema slike')),
                                ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          jelo?.naziv ?? 'Nepoznato jelo',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.orange),
                                        ),
                                        Text(
                                          datum,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    _buildStars((d.ocjena ?? 0).toDouble()),

                                    const SizedBox(height: 4),
                                    Text(
                                      d.opis ?? '',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Korisnik: $korisnik',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
