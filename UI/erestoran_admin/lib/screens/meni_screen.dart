/*import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/utils/util.dart';
import 'package:erestoran_admin/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
import '../models/search_result.dart';
import '../providers/jelo_provider.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/master_screen.dart';


class MeniScreen extends StatefulWidget {
  const MeniScreen({Key? key}) : super(key: key);

  @override
  State<MeniScreen> createState() => _MeniScreenState();
}

class _MeniScreenState extends State<MeniScreen> {
  late KategorijaProvider _kategorijaProvider;
  SearchResult<Kategorija>? result;
  final TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _kategorijaProvider.get();
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
      title_widget: const Text("Kategorija List"),
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
                var data = await _kategorijaProvider.get(filter: {
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
                  builder: (context) =>  ProductDetailScreen()
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
  return Expanded( // Dodajte Expanded
    child: ListView.builder(
      itemCount: result?.result.length ?? 0,
      itemBuilder: (context, index) {
        Kategorija e = result!.result[index];
        print('Row data: ID: ${e.id}, Naziv: ${e.naziv}, Opis: ${e.opis}');
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(),
                  ),
                );
              },
              child: Text(
                e.naziv ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(
              e.opis ?? '',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    ),
  );
}

}
*/


/*
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import '../screens/product_list_screen.dart';
import '../widgets/master_screen.dart';

class MeniScreen extends StatefulWidget {
  const MeniScreen({Key? key}) : super(key: key);

  @override
  State<MeniScreen> createState() => _MeniScreenState();
}

class _MeniScreenState extends State<MeniScreen> {
  late KategorijaProvider _kategorijaProvider;
  SearchResult<Kategorija>? result;
  final TextEditingController _nazivController = TextEditingController();
  Kategorija? _odabranaKategorija; // Dodano stanje za odabranu kategoriju

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _kategorijaProvider.get();
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
      title_widget: const Text("Kategorija List"),
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
                var data = await _kategorijaProvider.get(filter: {
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
                  builder: (context) => ProductDetailScreen(),
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
    final filteredResults = _odabranaKategorija != null 
        ? [_odabranaKategorija!] // Prikaži samo odabranu
        : result?.result ?? []; // Prikaži sve

    return Expanded(
      child: ListView.builder(
        itemCount: filteredResults.length,
        itemBuilder: (context, index) {
          Kategorija e = filteredResults[index];
          print('Row data: ID: ${e.id}, Naziv: ${e.naziv}, Opis: ${e.opis}');
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            child: ListTile(
              title: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _odabranaKategorija = e; // Postavi odabranu kategoriju
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(kategorija: e), // Prosledi kategoriju
                    ),
                  );
                },
                child: Text(
                  e.naziv ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                e.opis ?? '',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
/*
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import '../screens/product_list_screen.dart';
import '../widgets/master_screen.dart';

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
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Meni Kategorija"),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Pretraži kategoriju",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200], // Svijetlo siva pozadina
            ),
            controller: _nazivController,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[300], // Svijetlo siva boja za dugme
          ),
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
          child: const Text("Pretraži"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[300], // Svijetlo siva boja za dugme
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(),
              ),
            );
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }

  Widget _buildDataListView() {
    final filteredResults = _odabranaKategorija != null 
        ? [_odabranaKategorija!] 
        : result?.result ?? []; 

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        Kategorija e = filteredResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          color: Colors.white, // Bijela pozadina za kartice
          child: ListTile(
            title: Text(
              e.naziv ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black, // Crni ton za tekst
              ),
            ),
            subtitle: Text(
              e.opis ?? '',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.grey[600]), // Tamnija siva boja za ikonu
              onPressed: () {
                setState(() {
                  _odabranaKategorija = e;
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(kategorija: e),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}*/
/*
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import '../screens/product_list_screen.dart';
import '../widgets/master_screen.dart';

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
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Meni Kategorija"),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Pretraži kategoriju",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            controller: _nazivController,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
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
          child: const Text("Pretraži"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(),
              ),
            );
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }

  Widget _buildDataListView() {
    final filteredResults = _odabranaKategorija != null 
        ? [_odabranaKategorija!] 
        : result?.result ?? []; 

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        Kategorija e = filteredResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _odabranaKategorija = e;
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(kategorija: e),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.naziv ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e.opis ?? '',
                          style: TextStyle(color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.arrow_forward, color: Colors.blue),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/

import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import '../screens/product_list_screen.dart';
import '../widgets/master_screen.dart';

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
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Meni Kategorija"),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Pretraži kategoriju",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            controller: _nazivController,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
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
          child: const Text("Pretraži"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(),
              ),
            );
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }

  Widget _buildDataListView() {
    final filteredResults = _odabranaKategorija != null 
        ? [_odabranaKategorija!] 
        : result?.result ?? []; 

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        Kategorija e = filteredResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _odabranaKategorija = e;
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(kategorija: e),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.naziv ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[800], // Tamno siva boja
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    e.opis ?? '',
                    style: TextStyle(color: Colors.grey[800]), // Tamno siva boja
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
