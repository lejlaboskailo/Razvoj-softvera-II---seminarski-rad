/*import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
import '../models/search_result.dart';
import '../providers/jelo_provider.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/master_screen.dart';
import 'dart:convert'; // Dodaj ovo
import 'dart:typed_data'; // Dodaj ovo

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
              decoration: const InputDecoration(labelText: "naziv"),
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

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text('ID', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Naziv', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Cijena', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Slika', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ],
        rows: filteredResults?.map((Jelo e) {
          print('Row data: ID: ${e.id}, Naziv: ${e.naziv}, Cijena: ${e.cijena}, Slika: ${e.slika}');
          return DataRow(
            onSelectChanged: (selected) {
              if (selected == true) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(jelo: e),
                  ),
                );
              }
            },
            cells: [
              DataCell(Text(e.id?.toString() ?? '')),
              DataCell(Text(e.naziv ?? '')),
              DataCell(Text(e.cijena != null ? e.cijena!.toStringAsFixed(2) : '')),
              DataCell(
                /*(e.slika != null && e.slika!.isNotEmpty)
                    ? FutureBuilder<Widget>(
                        future: _loadImage(e.slika!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Greška sa slikom');
                          } else {
                            return snapshot.data!;
                          }
                        },
                      )*/
                      e.slika != ""
                ?Container(
                  width: 100,
                  height: 100,
                  child: imageFromBase64String(e.slika!),
                )
                    : Text('Nema slike'),
              ),
            ],
          );
        }).toList() ?? [],
      ),
    );
  }

  Future<Widget> _loadImage(String base64String) async {
    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(bytes, width: 100, height: 100);
    } catch (e) {
      print('Error decoding image: $e');
      return Text('Greška sa slikom');
    }
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
import 'dart:convert'; // Dodaj ovo
import 'dart:typed_data'; // Dodaj ovo

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

    return DataTable(
      columns: const [
        DataColumn(label: Text('ID', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Naziv', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Cijena', style: TextStyle(fontStyle: FontStyle.italic))),
        DataColumn(label: Text('Slika', style: TextStyle(fontStyle: FontStyle.italic))),
      ],
      rows: filteredResults?.map((Jelo e) {
        print('Row data: ID: ${e.id}, Naziv: ${e.naziv}, Cijena: ${e.cijena}, Slika: ${e.slika}');
        return DataRow(
          onSelectChanged: (selected) {
            if (selected == true) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(jelo: e),
                ),
              );
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
