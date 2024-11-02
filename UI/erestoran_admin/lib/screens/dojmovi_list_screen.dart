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
  // ignore: prefer_final_fields, unnecessary_new
  TextEditingController _nazivController = new TextEditingController();
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
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
    return Container(
      child: MasterScreenWidget(
        title_widget: Container(
          padding: const EdgeInsets.all(12),
          child: const Text("Dojmovi", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        child: Column(
          children: [
            _buildDataListView(),
          ],
        ),
      ),
    );
  }


Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 400,right:400), 
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columns: const [
              DataColumn(
                
                label: Expanded(
                  child: Text(
                    'Ocjena',
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
               DataColumn(
                
                label: Expanded(
                  child: Text(
                    'Opis',
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
               DataColumn(
                
                label: Expanded(
                  child: Text(
                    'Jelo',
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
               DataColumn(
                
                label: Expanded(
                  child: Text(
                    'Korisnik',
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
             
            ],
            rows: result?.result
                  .map(
                    (Dojmovi e) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            e.ocjena.toString()
                          ),
                          
                        ),
                        DataCell(
                          Text(
                            e.opis ?? "",
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                          
                        ),
                        DataCell(
                          Text(
                            e.jeloId.toString(),
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                          
                        ),
                        DataCell(
                          Text(
                            e.korisnikId.toString(),
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                          
                        ),
                        
                      ],
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