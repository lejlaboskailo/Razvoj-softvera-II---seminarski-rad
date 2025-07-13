import 'dart:convert';
import 'package:erestoran_mobile/screens/ocjena_jelo_screen.dart';
import 'package:erestoran_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
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
                        child: Icon(Icons.fastfood,
                            size: 60, color: Colors.orange),
                      ),
                    ),
              const SizedBox(height: 16),

              // Naziv
              Text(
                jelo.naziv ?? "Nepoznato jelo",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),

              // Opis
              Text(
                jelo.opis ?? "Nema opisa za ovo jelo.",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Cijena
              if (jelo.cijena != null)
                Text(
                  "Cijena: ${jelo.cijena!.toStringAsFixed(2)} KM",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 16),

              // Količina +/-
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.orange),
                    onPressed: () {
                      setState(() {
                        if (_kolicina > 1) {
                          _kolicina--;
                        }
                      });
                    },
                  ),
                  Text(
                    '$_kolicina',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.orange),
                    onPressed: () {
                      setState(() {
                        _kolicina++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Dugmad
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        print("ULOGA JSON: ${Authorization.uloga?.toJson()}");
                        print("ULOGA ID: ${Authorization.uloga?.ulogaId}");

                        if (Authorization.uloga == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Greška: korisnik nije prijavljen."),
                            ),
                          );
                          return;
                        }

                        if (Authorization.uloga!.ulogaId != 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Nemate dozvolu za ovu akciju."),
                            ),
                          );
                          return;
                        }

                        final payload = {
                          "jeloId": jelo.jeloId,
                          "korisnikId": Authorization.userId,
                          "kolicina": _kolicina,
                          "kategorijaId": jelo.kategorijaId,
                          "cijena": jelo.cijena
                        };

                        context.read<CartProvider>().insert(payload).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${jelo.naziv} je dodano u korpu."),
                            ),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Greška prilikom dodavanja u korpu: $error"),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "Dodaj u korpu",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Otkaži",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OcjenaJeloScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Ocijeni jelo",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
