import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dojmovi.dart';
import '../models/search_result.dart';
import '../providers/dojmovi_provider.dart';
import '../widgets/master_screen.dart';

class DojmoiListScreen extends StatefulWidget {
  const DojmoiListScreen({Key? key}) : super(key: key);

  @override
  State<DojmoiListScreen> createState() => _DojmoviListScreenState();
}

class _DojmoviListScreenState extends State<DojmoiListScreen> {
  late DojmoviProvider _dojmoviProvider;
  SearchResult<Dojmovi>? result;
  TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dojmoviProvider = context.read<DojmoviProvider>();
    _loadData();
  }

  Future<void> _loadData() async {
    var data = await _dojmoviProvider.get(filter: {'naziv': _nazivController.text});
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.orange,
            padding: const EdgeInsets.all(12),
            child: Text(
              "Dojmovi",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          _buildDataListView(),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: result?.result
                    .map(
                      (Dojmovi e) => Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ocjena: ${e.ocjena}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[700],
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Opis: ${e.opis ?? "Nema opisa"}',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Jelo ID: ${e.jeloId}',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Korisnik ID: ${e.korisnikId}',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.info_outline, color: Colors.orange[700]),
                                onPressed: () {
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
      ),
    );
  }
}


