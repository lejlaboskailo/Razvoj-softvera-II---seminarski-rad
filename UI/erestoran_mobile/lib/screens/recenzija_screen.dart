import 'package:erestoran_mobile/models/dojmovi.dart';
import 'package:erestoran_mobile/models/search_result.dart';
import 'package:erestoran_mobile/providers/dojmovi_provider.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/jelo.dart';
import '../providers/jelo_provider.dart';
import '../widgets/master_screen.dart';

class RecenzijaScreen extends StatefulWidget {
  const RecenzijaScreen({Key? key}) : super(key: key);

  @override
  State<RecenzijaScreen> createState() => _RecenzijaScreen();
}

class _RecenzijaScreen extends State<RecenzijaScreen> {
  late DojmoviProvider _dojmoviProvider;
  late ProductProvider _jeloProvider;
  late KorisnikProvider _korisnikProvider;


  SearchResult<Dojmovi>? stavkeResult;
  Map<String, String> jeloMap = {};
  Map<String, String> korisnikMap = {};

  final TextEditingController _nazivController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dojmoviProvider = context.read<DojmoviProvider>();
    _jeloProvider = context.read<ProductProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();


    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      stavkeResult = await _dojmoviProvider.get();

      var jeloResult = await _jeloProvider.get();
      var korisnikResult = await _korisnikProvider.get();


      if (jeloResult?.result != null && korisnikResult!.result!=null) {
        setState(() {
          jeloMap = {
            for (var jelo in jeloResult!.result)
              jelo.jeloId.toString(): jelo.naziv ?? ''
          };
          korisnikMap = {
            for (var korisnik in korisnikResult!.result)
              korisnik.id.toString(): korisnik.ime ?? ''
          };

          print('Jelo Map: $jeloMap');
          print('Jelo Map: $korisnikMap');

        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Recenzije korisnika"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: _buildDataListView()),
          ],
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(
            label:
                Text('Ocjena', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Opis', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Naziv Jela',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label:
                Text('Korisnik', style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ],
        rows: stavkeResult?.result.map((Dojmovi e) {
              String nazivJela = jeloMap[e.jeloId.toString()] ?? 'Nepoznato';
              String imeKorisnika = korisnikMap[e.korisnikId.toString()] ?? 'Nepoznato';


              return DataRow(
                cells: [
                  DataCell(Text(e.ocjena?.toString() ?? '')),
                  DataCell(Text(e.opis?.toString() ?? '')),
                  DataCell(Text(nazivJela)),
                  DataCell(Text(imeKorisnika)),
                ],
              );
            }).toList() ??
            [],
      ),
    );
  }
}
