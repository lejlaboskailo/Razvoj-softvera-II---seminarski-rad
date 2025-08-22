import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/providers/meni_provider.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
 
class RecommendedJeloScreen extends StatefulWidget {
  @override
  _RecommendedJeloScreenState createState() => _RecommendedJeloScreenState();
}
 
class _RecommendedJeloScreenState extends State<RecommendedJeloScreen> {
  final MeniProvider jeloProvider = MeniProvider();
  List<Jelo>? _jelo;
 
  @override
  void initState() {
    super.initState();
    _fetchJelo();
  }
 
  Future<void> _fetchJelo() async {
    try {
      _jelo = await jeloProvider.fetchRecommendedJelo();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
    setState(() {});
  }
 
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: _jelo != null
          ? ListView.builder(
              itemCount: _jelo!.length,
              itemBuilder: (context, index) {
                final jelo = _jelo![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text('${jelo.naziv}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
 
}