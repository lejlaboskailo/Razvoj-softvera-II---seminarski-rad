import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/search_result.dart';
import 'package:erestoran_admin/models/kategorija.dart';

import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';

import 'package:erestoran_admin/screens/product_detail_screen.dart';

class MeniScreen extends StatefulWidget {
  const MeniScreen({Key? key}) : super(key: key);

  @override
  State<MeniScreen> createState() => _MeniScreenState();
}

class _MeniScreenState extends State<MeniScreen> {
  late KategorijaProvider _kategorijaProvider;
  late ProductProvider _jeloProvider;

  SearchResult<Kategorija>? _kategorije;
  SearchResult<Jelo>? _jela;

  final TextEditingController _nazivController = TextEditingController();

  int? _selectedKategorijaId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _jeloProvider = context.read<ProductProvider>();

    _fetchKategorije();
    _fetchJela();
  }

  Future<void> _fetchKategorije() async {
    try {
      final data = await _kategorijaProvider.get();
      setState(() {
        _kategorije = data;

        if (_selectedKategorijaId != null &&
            !((_kategorije?.result ?? [])
                .any((k) => k.kategorijaId == _selectedKategorijaId))) {
          _selectedKategorijaId = null;
        }
      });
    } catch (e) {
      debugPrint('Greška pri dohvaćanju kategorija: $e');
    }
  }

  Future<void> _fetchJela() async {
    try {
      final data = await _jeloProvider.get();
      setState(() => _jela = data);
    } catch (e) {
      debugPrint('Greška pri dohvaćanju jela: $e');
    }
  }

  Future<void> _searchJela() async {
    try {
      final filter = <String, dynamic>{};

      if (_nazivController.text.isNotEmpty) {
        filter['Naziv'] = _nazivController.text;
      }
      if (_selectedKategorijaId != null) {
        filter['KategorijaId'] = _selectedKategorijaId;
      }

      debugPrint('Šaljem filter: $filter');

      final data = await _jeloProvider.get(filter: filter);
      setState(() => _jela = data);
    } catch (e) {
      debugPrint('Greška pri pretrazi: $e');
    }
  }

  ImageProvider? _imageForJelo(Jelo j) {
    final raw = j.slika;
    if (raw == null || raw.isEmpty) return null;

    if (raw.startsWith('http')) return NetworkImage(raw);

    try {
      final bytes = base64Decode(raw);
      return MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _jela?.result ?? [];
    final kategorije = _kategorije?.result ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meni'),
        leading: (ModalRoute.of(context)?.canPop ?? false)
            ? BackButton(onPressed: () => Navigator.of(context).pop())
            : null,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
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
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                        onSubmitted: (_) => _searchJela(),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedKategorijaId,
                  hint: const Text("Odaberi kategoriju"),
                  items: kategorije
                      .map(
                        (k) => DropdownMenuItem<int>(
                          value: k.kategorijaId,
                          child: Text(k.naziv ?? "Bez naziva"),
                        ),
                      )
                      .toList(),
                  onChanged: (newId) {
                    setState(() => _selectedKategorijaId = newId);
                    _searchJela();
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _searchJela,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text(
                        "Pretraži",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          _selectedKategorijaId = null;
                          _nazivController.clear();
                        });
                        await _fetchJela();
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 100,
                  childAspectRatio: 3 / 2,
                  mainAxisExtent: 260,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final jelo = items[index];
                  final imgProvider = _imageForJelo(jelo);

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
                                child: Container(
                                  color: Colors.grey.shade200,
                                  child: imgProvider != null
                                      ? Image(
                                          image: imgProvider,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                          errorBuilder: (c, e, s) =>
                                              const Center(
                                            child: Icon(Icons.broken_image,
                                                size: 40, color: Colors.orange),
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(Icons.fastfood,
                                              size: 50, color: Colors.orange),
                                        ),
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                                          'Da li ste sigurni da želite obrisati jelo "${jelo.naziv}"?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("Otkaži"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: const Text("Obriši"),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmed == true) {
                                      try {
                                        await _jeloProvider
                                            .delete(jelo.jeloId!);
                                        await _fetchJela();
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Jelo "${jelo.naziv}" je obrisano.',
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        debugPrint(
                                            "Greška prilikom brisanja: $e");
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Greška prilikom brisanja jela."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity, 
            child: ElevatedButton(
              onPressed: () async {
                final changed = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ProductDetailScreen()),
                );
                await _fetchJela();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(48), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Dodaj jelo",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
