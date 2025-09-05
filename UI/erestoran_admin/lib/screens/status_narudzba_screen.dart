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
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      var data = await _statusNarudzbeProvider.get();
      var narudzbaResults = await _narudzbaProvider.get();
      var korisnikResults = await _korisnikProvider.get();

      setState(() {
        result = data;
        narudzbaResult = narudzbaResults;
        korisnikResult = korisnikResults;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child:
            result == null || narudzbaResult == null || korisnikResult == null
                ? Center(child: CircularProgressIndicator())
                : _buildStatusList(),
      ),
    );
  }

  Widget _buildStatusList() {
    return ListView.builder(
      itemCount: result?.result.length ?? 0,
      itemBuilder: (context, index) {
        var status = result!.result[index];
        var filteredNarudzbe = narudzbaResult?.result.where((narudzba) {
          return narudzba.statusNarudzbeId == status.id;
        }).toList();

        return _buildStatusCard(status, filteredNarudzbe);
      },
    );
  }

  Widget _buildStatusCard(
      StatusNarudzbe status, List<Narudzba>? filteredNarudzbe) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status.naziv ?? "Nepoznati status",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Broj narudžbi: ${filteredNarudzbe?.length ?? 0}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              _buildNarudzbeDetails(filteredNarudzbe),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNarudzbeDetails(List<Narudzba>? filteredNarudzbe) {
    if (filteredNarudzbe == null || filteredNarudzbe.isEmpty) {
      return Text(
        "Nema narudžbi za ovaj status.",
        style: TextStyle(color: Colors.black54),
      );
    }

    return Column(
      children: filteredNarudzbe.map((narudzba) {
        String datumText = "Nepoznato";
        if (narudzba.datumNarudzbe != null &&
            narudzba.datumNarudzbe!.isNotEmpty) {
          try {
            DateTime dt = DateTime.parse(narudzba.datumNarudzbe!);
            datumText = DateFormat('dd.MM.yyyy').format(dt); 
          } catch (_) {
            datumText =
                narudzba.datumNarudzbe!; 
          }
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Datum: $datumText",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Expanded(
                child: Text(
                  "Korisnik: ${_getKorisnikIme(narudzba.korisnikId) ?? "Nepoznat korisnik"}",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Expanded(
                child: Text(
                  "Stanje: ${narudzba.stateMachine ?? "Nepoznato"}",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
