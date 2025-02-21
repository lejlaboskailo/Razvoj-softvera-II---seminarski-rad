import 'package:erestoran_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erestoran_mobile/models/kategorija.dart';
import 'package:erestoran_mobile/screens/product_list_screen.dart';
import '../models/search_result.dart';
import '../widgets/master_screen.dart';
import 'package:erestoran_mobile/providers/kategorija_provider.dart';

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

  // Function to handle search query and filter data
  void _searchCategories(String query) {
    if (query.isEmpty) {
      // If the search is empty, show all results
      _fetchInitialData();
    } else {
      // Otherwise, filter the categories by the entered query
      setState(() {
        result?.result = result!.result
            .where((category) => category.naziv
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
                false)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Meni Kategorija"),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/home.jpg', // Your background image
              fit: BoxFit.cover,
            ),
          ),
          // Main content of the page
          Padding(
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
        ],
      ),
    );
  }

  // Build the search bar with real-time search
  Widget _buildSearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _nazivController,
            decoration: InputDecoration(
              labelText: "Pretraži kategoriju",
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onChanged: _searchCategories, // Trigger search on text change
          ),
        ),
        const SizedBox(width: 8),
        
      ],
    );
  }

  // Build the list view of the categories
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
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    e.opis ?? '',
                    style: TextStyle(color: Colors.grey[800]),
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
