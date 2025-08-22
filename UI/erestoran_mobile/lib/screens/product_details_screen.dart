import 'dart:convert';
import 'package:erestoran_mobile/providers/prilozi_provider.dart';
import 'package:erestoran_mobile/screens/ocjena_jelo_screen.dart';
import 'package:erestoran_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/jelo.dart';
import '../models/prilozi.dart';
import '../providers/cart_provider.dart';
import '../widgets/master_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Jelo jelo;
  const ProductDetailScreen({Key? key, required this.jelo}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _kolicina = 1;

  late PriloziProvider _prilogProvider;
  bool _loadingPrilozi = true;
  List<Prilozi> _prilozi = [];
  Prilozi? _selectedPrilog;

  @override
  void initState() {
    super.initState();
    _prilogProvider = context.read<PriloziProvider>();
    _loadPrilozi();
  }

  Future<void> _loadPrilozi() async {
    try {
      final res = await _prilogProvider.get();
      setState(() {
        _prilozi = res.result;
        _loadingPrilozi = false;
      });
    } catch (e) {
      setState(() => _loadingPrilozi = false);
      // nije fatalno — može se dodati bez priloga
    }
  }

  @override
  Widget build(BuildContext context) {
    final jelo = widget.jelo;

    return MasterScreenWidget(
      title: jelo.naziv ?? "Detalji proizvoda",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slika
              jelo.slika != null && jelo.slika!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        base64Decode(jelo.slika!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    )
                  : Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange[100],
                      ),
                      child: const Center(
                        child: Icon(Icons.fastfood, size: 60, color: Colors.orange),
                      ),
                    ),
              const SizedBox(height: 16),

              // Naziv
              Text(
                jelo.naziv ?? "Nepoznato jelo",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 8),

              // Opis
              Text(jelo.opis ?? "Nema opisa za ovo jelo.", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),

              // Cijena
              if (jelo.cijena != null)
                Text(
                  "Cijena: ${jelo.cijena!.toStringAsFixed(2)} KM",
                  style: const TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16),

              // Količina +/- 
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.orange),
                    onPressed: () => setState(() {
                      if (_kolicina > 1) _kolicina--;
                    }),
                  ),
                  Text('$_kolicina', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.orange),
                    onPressed: () => setState(() => _kolicina++),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // DROPDOWN: Odaberi prilog (opcionalno)
              _loadingPrilozi
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: LinearProgressIndicator(),
                    )
                  : DropdownButtonFormField<Prilozi>(
                      value: _selectedPrilog,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Odaberi prilog (opcionalno)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      items: _prilozi
                          .map((p) => DropdownMenuItem<Prilozi>(
                                value: p,
                                child: Text(p.nazivPriloga ?? ''),
                              ))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedPrilog = val),
                    ),
              const SizedBox(height: 24),

              // Dugmad: Dodaj u korpu / Otkaži
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (Authorization.uloga == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Greška: korisnik nije prijavljen.")),
                          );
                          return;
                        }
                        if (Authorization.uloga!.ulogaId != 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Nemate dozvolu za ovu akciju.")),
                          );
                          return;
                        }

                        final payload = {
                          "jeloId": jelo.jeloId,
                          "korisnikId": Authorization.userId,
                          "kolicina": _kolicina,
                          "kategorijaId": jelo.kategorijaId,
                          "cijena": jelo.cijena,
                          "prilogId": _selectedPrilog?.prilogId, 
                        };

                        context.read<CartProvider>().insert(payload).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${jelo.naziv} je dodano u korpu.")),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Greška prilikom dodavanja u korpu: $error")),
                          );
                        });
                      },
                      child: const Text("Dodaj u korpu", style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Otkaži", style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Ocijeni jelo
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OcjenaJeloScreen()));
                },
                child: const Text("Ocijeni jelo", style: TextStyle(color: Colors.black, fontSize: 16)),
              ),

              // NEMA više Expanded unutar scrolla!
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
