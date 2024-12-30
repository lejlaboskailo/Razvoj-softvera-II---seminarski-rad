/*import 'package:erestoran_admin/models/kategorija.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
import '../models/search_result.dart';
import '../providers/jelo_provider.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/master_screen.dart';
import 'dart:convert';
import 'dart:typed_data'; 

class ProductListScreen extends StatefulWidget {
  final Kategorija? kategorija;

  const ProductListScreen({Key? key, this.kategorija}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Jelo>? result;
  final TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _productProvider.get();
      print('Fetched data: ${data.result}');
      setState(() {
        result = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        widget.kategorija != null 
          ? "Proizvodi za ${widget.kategorija!.naziv}" 
          : "Lista Proizvoda",
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearch(),
            Expanded(child: _buildDataListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Naziv"),
              controller: _nazivController,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              try {
                var data = await _productProvider.get(filter: {
                  'naziv': _nazivController.text, 
                });
                print('Search result: ${data.result}');
                setState(() {
                  result = data;
                  var filteredData=data.result.where((jelo){
                    var nazivJEla=jelo.naziv!.toLowerCase().contains(_nazivController.text.toLowerCase());

                  return nazivJEla;
                  }).toList();
                });
              } catch (e) {
                print('Error during search: $e');
              }
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(jelo: null),
                ),
              );
              _fetchInitialData();
            },
            child: const Text("Dodaj"),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    print('Result: ${result?.result}');
    
    // Filtriranje rezultata prema kategoriji, ako je prisutna
    final filteredResults = widget.kategorija != null 
        ? result?.result.where((jelo) => jelo.kategorijaId == widget.kategorija!.id).toList() 
        : result?.result ?? [];

    // Ako je pretraga aktivna, filtriraj proizvode prema nazivu koji sadrži unos
    final searchQuery = _nazivController.text.toLowerCase();
    final finalResults = searchQuery.isNotEmpty
        ? filteredResults?.where((jelo) => jelo.naziv!.toLowerCase().contains(searchQuery)).toList()
        : filteredResults;

    return DataTable(
      columns: const [
        DataColumn(label: Text('ID', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Naziv', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Cijena', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Slika', style: TextStyle(fontStyle: FontStyle.italic))),
      ],
      rows: finalResults?.map((Jelo e) {
        print('Row data: ID: ${e.id}, Naziv: ${e.naziv}, Cijena: ${e.cijena}, Slika: ${e.slika}');
        return DataRow(
          onSelectChanged: (selected) {
            if (selected == true) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(jelo: e),
                ),
              ).then((_) {
                _fetchInitialData();
              });
            }
          },
          cells: [
            DataCell(Text(e.id?.toString() ?? '')),
            DataCell(Text(e.naziv ?? '')),
            DataCell(Text(e.cijena != null ? e.cijena!.toStringAsFixed(2) : '')),
            DataCell(
              e.slika != null && e.slika!.isNotEmpty
                ? Container(
                    width: 100,
                    height: 100,
                    child: imageFromBase64String(e.slika!),
                  )
                : Text('Nema slike'),
            ),
          ],
        );
      }).toList() ?? [],
    );
  }

  Widget imageFromBase64String(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes, width: 100, height: 100);
  }
}
*/
/*
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
import '../models/search_result.dart';
import '../providers/jelo_provider.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/master_screen.dart';
import 'dart:convert';
import 'dart:typed_data'; 

class ProductListScreen extends StatefulWidget {
  final Kategorija? kategorija;

  const ProductListScreen({Key? key, this.kategorija}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Jelo>? result;
  final TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _productProvider.get();
      print('Fetched data: ${data.result}');
      setState(() {
        result = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        widget.kategorija != null 
          ? "Proizvodi za ${widget.kategorija!.naziv}" 
          : "Lista Proizvoda",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearch(),
            const SizedBox(height: 16),
            Expanded(child: _buildDataListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Naziv",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: _nazivController,
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                var data = await _productProvider.get(filter: {
                  'naziv': _nazivController.text, 
                });
                print('Search result: ${data.result}');
                setState(() {
                  result = data;
                });
              } catch (e) {
                print('Error during search: $e');
              }
            },
            icon: const Icon(Icons.search),
            label: const Text("Pretraga"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(jelo: null),
                ),
              ).then((_) => _fetchInitialData());
            },
            icon: const Icon(Icons.add),
            label: const Text("Dodaj"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    print('Result: ${result?.result}');

    final filteredResults = widget.kategorija != null 
        ? result?.result.where((jelo) => jelo.kategorijaId == widget.kategorija!.id).toList() 
        : result?.result ?? [];

    final searchQuery = _nazivController.text.toLowerCase();
    final finalResults = searchQuery.isNotEmpty
        ? filteredResults?.where((jelo) => jelo.naziv!.toLowerCase().contains(searchQuery)).toList()
        : filteredResults;

    return Card(
      elevation: 4,
      child: DataTable(
        columnSpacing: 16.0,
        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Naziv')),
          DataColumn(label: Text('Cijena')),
          DataColumn(label: Text('Slika')),
        ],
        rows: finalResults?.map((Jelo e) {
          return DataRow(
            onSelectChanged: (selected) {
              if (selected == true) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(jelo: e),
                  ),
                ).then((_) => _fetchInitialData());
              }
            },
            cells: [
              DataCell(Text(e.id?.toString() ?? '')),
              DataCell(Text(e.naziv ?? '')),
              DataCell(Text(e.cijena != null ? "${e.cijena!.toStringAsFixed(2)} KM" : '')),
              DataCell(
                e.slika != null && e.slika!.isNotEmpty
                  ? Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: MemoryImage(base64Decode(e.slika!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const Text('Nema slike'),
              ),
            ],
          );
        }).toList() ?? [],
      ),
    );
  }
}
*/

import 'package:erestoran_admin/models/kategorija.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
import '../models/search_result.dart';
import '../providers/jelo_provider.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/master_screen.dart';
import 'dart:convert';
import 'dart:typed_data'; 

class ProductListScreen extends StatefulWidget {
  final Kategorija? kategorija;

  const ProductListScreen({Key? key, this.kategorija}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Jelo>? result;
  final TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _productProvider.get();
      print('Fetched data: ${data.result}');
      setState(() {
        result = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        widget.kategorija != null 
          ? "Proizvodi za ${widget.kategorija!.naziv}" 
          : "Lista Proizvoda",
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearch(),
            Expanded(child: _buildDataListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Naziv",
                labelStyle: TextStyle(color: Colors.orange),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              controller: _nazivController,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () async {
              try {
                var data = await _productProvider.get(filter: {
                  'naziv': _nazivController.text, 
                });
                print('Search result: ${data.result}');
                setState(() {
                  result = data;
                });
              } catch (e) {
                print('Error during search: $e');
              }
            },
            child: const Text("Pretraga"),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(jelo: null),
                ),
              ).then((_) {
                _fetchInitialData();
              });
            },
            child: const Text("Dodaj"),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    print('Result: ${result?.result}');
    
    final filteredResults = widget.kategorija != null 
        ? result?.result.where((jelo) => jelo.kategorijaId == widget.kategorija!.id).toList() 
        : result?.result ?? [];

    final searchQuery = _nazivController.text.toLowerCase();
    final finalResults = searchQuery.isNotEmpty
        ? filteredResults?.where((jelo) => jelo.naziv!.toLowerCase().contains(searchQuery)).toList()
        : filteredResults;

    return DataTable(
      columns: const [
        DataColumn(label: Text('ID', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange))),
        DataColumn(label: Text('Naziv', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange))),
        DataColumn(label: Text('Cijena', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange))),
        DataColumn(label: Text('Slika', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange))),
        DataColumn(label: Text('Akcije', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange))),
      ],
      rows: finalResults?.map((Jelo e) {
        print('Row data: ID: ${e.id}, Naziv: ${e.naziv}, Cijena: ${e.cijena}, Slika: ${e.slika}');
        return DataRow(
          onSelectChanged: (selected) {
            if (selected == true) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(jelo: e),
                ),
              ).then((_) {
                _fetchInitialData();
              });
            }
          },
          cells: [
            DataCell(Text(e.id?.toString() ?? '')),
            DataCell(Text(e.naziv ?? '')),
            DataCell(Text(e.cijena != null ? e.cijena!.toStringAsFixed(2) : '')),
            DataCell(
              e.slika != null && e.slika!.isNotEmpty
                ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(e.slika!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Text('Nema slike'),
            ),
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(jelo: e),
                      ),
                    ).then((_) {
                      _fetchInitialData();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Potvrda brisanja"),
                        content: Text("Da li ste sigurni da želite obrisati proizvod \"${e.naziv}\"?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Ne"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Da"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      try {
                        await _productProvider.delete(e.id!);
                        _fetchInitialData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Proizvod \"${e.naziv}\" je uspješno obrisan.")),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Greška prilikom brisanja proizvoda: $error")),
                        );
                      }
                    }
                  },
                ),
              ],
            )),
          ],
        );
      }).toList() ?? [],
    );
  }
}
