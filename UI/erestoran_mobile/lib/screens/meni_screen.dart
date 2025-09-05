import 'dart:convert';

import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/models/search_result.dart';
import 'package:erestoran_mobile/providers/jelo_provider.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import '../models/kategorija.dart';
import '../providers/kategorija_provider.dart';
import 'package:provider/provider.dart';
import 'product_details_screen.dart';

class MeniScreen extends StatefulWidget {
  const MeniScreen({Key? key}) : super(key: key);

  @override
  State<MeniScreen> createState() => _MeniScreenState();
}

class _MeniScreenState extends State<MeniScreen> {
  late KategorijaProvider _kategorijaProvider;
  late ProductProvider _jeloProvider;
  SearchResult<Kategorija>? result;
  SearchResult<Jelo>? jeloResult;
  final TextEditingController _nazivController = TextEditingController();
  Kategorija? _odabranaKategorija;
  Jelo? _odabranoJelo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _jeloProvider = context.read<ProductProvider>();

    _fecthKategorija();
    _fecthJelo();
  }

  Future<void> _fecthKategorija() async {
    try {
      var data = await _kategorijaProvider.get();
      setState(() {
        result = data;
      });
    } catch (e) {
      print('Error fetching kategorije: $e');
    }
  }

  Future<void> _fecthJelo() async {
    try {
      var data = await _jeloProvider.get();
      setState(() {
        jeloResult = data;
      });
    } catch (e) {
      print('Error fetching jela: $e');
    }
  }

  Future<void> _searchJela() async {
    try {
      Map<String, dynamic> filter = {};

      if (_nazivController.text.isNotEmpty) {
        filter['naziv'] = _nazivController.text;
      }

      if (_odabranaKategorija != null) {
        filter['kategorijaId'] = _odabranaKategorija!.kategorijaId;
      }

      print("Šaljem filter: $filter");

      var data = await _jeloProvider.get(filter: filter);
      setState(() {
        jeloResult = data;
      });
    } catch (e) {
      print('Error during search: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nazivController,
                        decoration: const InputDecoration(
                            labelText: "Pretraži jela",
                            border: UnderlineInputBorder(),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            labelStyle:
                                TextStyle(color: Color.fromARGB(255, 3, 3, 3))),
                        style: const TextStyle(color: Colors.black),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _searchJela,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 184, 178, 60)),
                      child: const Text(
                        "Pretraži",
                        style:
                            TextStyle(color: Color.fromARGB(255, 22, 22, 21)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButton<Kategorija>(
                  isExpanded: true,
                  value: _odabranaKategorija,
                  hint: const Text("Odaberi kategoriju"),
                  items: result?.result
                      .map(
                        (kategorija) => DropdownMenuItem<Kategorija>(
                          value: kategorija,
                          child: Text(kategorija.naziv ?? "Bez naziva"),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _odabranaKategorija = newValue;
                    });
                    _searchJela();
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _odabranaKategorija = null;
                          _nazivController.clear();
                        });
                        _fecthJelo();
                      },
                      child: const Text("Resetuj filtere"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(builder: (context) {
                final query = _nazivController.text.toLowerCase();

                final filteredList = jeloResult?.result
                        .where((jelo) =>
                            (jelo.naziv ?? "").toLowerCase().startsWith(query))
                        .toList() ??
                    [];

                if (filteredList.isEmpty) {
                  return const Center(child: Text("Nema jela za prikaz"));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 100,
                    childAspectRatio: 3 / 2,
                    mainAxisExtent: 260,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final jelo = filteredList[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(jelo: jelo),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: (jelo.slika != null &&
                                          jelo.slika!.isNotEmpty)
                                      ? Image.memory(
                                          base64Decode(jelo.slika!),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                              child: Text('Nema slike')),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                jelo.naziv ?? "Nepoznato jelo",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                jelo.opis ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () async {
                                      final confirmed = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Potvrda brisanja"),
                                          content: Text(
                                              "Da li ste sigurni da želite obrisati jelo \"${jelo.naziv}\"?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("Otkaži"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              child: const Text("Obriši"),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirmed == true) {
                                        try {
                                          await _jeloProvider
                                              .delete(jelo.jeloId!);
                                          _fecthJelo();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Jelo \"${jelo.naziv}\" je obrisano."),
                                            ),
                                          );
                                        } catch (e) {
                                          print("Greška prilikom brisanja: $e");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Greška prilikom brisanja jela."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
