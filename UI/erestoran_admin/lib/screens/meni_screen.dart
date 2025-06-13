import 'package:erestoran_admin/models/search_result.dart';
import 'package:flutter/material.dart';
import '../models/kategorija.dart';
import '../providers/kategorija_provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/product_list_screen.dart';
import '../widgets/master_screen.dart';
import 'package:provider/provider.dart';

class MeniScreen extends StatefulWidget {
  const MeniScreen({Key? key}) : super(key: key);

  @override
  State<MeniScreen> createState() => _MeniScreenState();
}

class _MeniScreenState extends State<MeniScreen> {
  late KategorijaProvider _kategorijaProvider;
  SearchResult<Kategorija>? result;
  final TextEditingController _nazivController = TextEditingController();
  Kategorija? _odabranaKategorija;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _kategorijaProvider.get();
      setState(() {
        result = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          labelText: "Pretraži kategoriju", 
                          border: UnderlineInputBorder(),
                          filled: true,
                          fillColor:Color.fromARGB(255, 255, 255, 255),
                          labelStyle: TextStyle(color: Color.fromARGB(255, 3, 3, 3))
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          var data = await _kategorijaProvider.get(filter: {
                            'naziv': _nazivController.text,
                          });
                          setState(() {
                            result = data;
                          });
                        } catch (e) {
                          print('Error during search: $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: const Text("Pretraži", style: TextStyle(color: Color.fromARGB(255, 22, 22, 21)),),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(),
                      ),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Dodaj", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),),
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
                itemCount: result?.result.length ?? 0,
                itemBuilder: (context, index) {
                  final kategorija = result!.result[index];
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
                                ProductListScreen(kategorija: kategorija),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.orange[100],
                                ),
                                child: const Center(
                                  child: Icon(Icons.fastfood,
                                      size: 50, color: Colors.orange),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              kategorija.naziv ?? "Nepoznata kategorija",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              kategorija.opis ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey),
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
        ],
      ),
    );
  }
}
