import 'dart:async';

import 'package:erestoran_admin/models/korisnik.dart';
import 'package:erestoran_admin/models/narudzba.dart';
import 'package:erestoran_admin/models/search_result.dart';
import 'package:erestoran_admin/models/statusNarudzbe.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/providers/narudzbu_provider.dart';
import 'package:erestoran_admin/providers/statusNarudzbe_provider.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StatusNarudzbaScreen extends StatefulWidget {

  @override
  State<StatusNarudzbaScreen> createState() => _StatusNarudzbaScreen();
}

class _StatusNarudzbaScreen extends State<StatusNarudzbaScreen> {
  late StatusNarudzbeProvider _statusNarudzbeProvider;
  late NarudzbaProvider _narudzbaProvider;
  late KorisnikProvider _korisnikProvider;


  SearchResult<StatusNarudzbe>? result;
  SearchResult<Narudzba>? narudzbaResult;
  SearchResult<Korisnik>? korisnikResult;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _statusNarudzbeProvider = context.read<StatusNarudzbeProvider>();
    _narudzbaProvider=context.read<NarudzbaProvider>();
    _korisnikProvider=context.read<KorisnikProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _statusNarudzbeProvider.get();
    var narudzbaResults=await _narudzbaProvider.get();
    var korisnikResults=await _korisnikProvider.get();

    setState(() {
      result = data;
      narudzbaResult=narudzbaResults;
      korisnikResult=korisnikResults;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text(
        "Status narudzbe",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Container(
        child: Column(
          children: [
            _buildDataListView(),
          ],
        ),
      ),
    );
  }


  Expanded _buildDataListView() {
  return Expanded(
    child: SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Status narudzbe',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Broj Narudžbi',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Datum narudzbe',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Korisnik',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'State Machine',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: result?.result.map((StatusNarudzbe e) {
          var filteredNarudzbe = narudzbaResult?.result.where((narudzba) {
            return narudzba.statusNarudzbeId == e.id;
          }).toList();

          return DataRow(
            cells: [
              DataCell(Text(e.naziv ?? "")),
              DataCell(Text(filteredNarudzbe?.length.toString() ?? "0")),
              for (var narudzba in filteredNarudzbe ?? [])
                DataCell(Text(narudzba.datumNarudzbe ?? "")),
              for (var narudzba in filteredNarudzbe ?? []) 
                DataCell(Text(
                  _getKorisnikIme(narudzba.korisnikId) ?? "Nepoznat korisnik")),
              for (var narudzba in filteredNarudzbe ?? [])
                DataCell(Text(narudzba.stateMachine ?? "")),
            ],
          );
        }).toList() ?? [],
      ),
    ),
  );
}

String? _getKorisnikIme(int? korisnikId) {
  var korisnik = korisnikResult?.result.firstWhere(
    (k) => k.id == korisnikId,
    orElse: () => Korisnik(id: 0, ime: 'Nepoznat korisnik'),
  );
  return korisnik?.ime; 
}
}