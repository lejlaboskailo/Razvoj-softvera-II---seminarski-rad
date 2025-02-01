/*import 'package:erestoran_admin/providers/uplata_po_korisniku_provider.dart';
import 'package:flutter/material.dart';
import 'package:erestoran_admin/models/uplata_po_korisniku.dart';

class UplatePoKorisnikuReport extends StatefulWidget {
  @override
  _UplatePoKorisnikuReportState createState() =>
      _UplatePoKorisnikuReportState();
}

class _UplatePoKorisnikuReportState extends State<UplatePoKorisnikuReport> {
  late UplatePoKorisnikuProvider _uplatePoKorisnikuProvider;
  late Future<List<UplataPoKorisniku>> _uplateFuture;

  @override
  void initState() {
    super.initState();
    _uplatePoKorisnikuProvider = UplatePoKorisnikuProvider();
    _uplateFuture = _uplatePoKorisnikuProvider.fetchUplate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uplate po korisniku"),
      ),
      body: FutureBuilder<List<UplataPoKorisniku>>(
        future: _uplateFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Greška: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nema podataka za prikaz."));
          } else {
            List<UplataPoKorisniku> uplate = snapshot.data!;
            return ListView.builder(
              itemCount: uplate.length,
              itemBuilder: (context, index) {
                final uplata = uplate[index];
                return ListTile(
                  title: Text("${uplata.imeKorisnika} ${uplata.prezimeKorisnika}"),
                  subtitle: Text(
                    "Iznos: ${uplata.iznos} | Datum: ${uplata.datumTransakcije}",
                  ),
                  trailing: Text(uplata.nacinPlacanja ?? "Nepoznato"),
                );
              },
            );
          }
        },
      ),
    );
  }
}*/

import 'package:erestoran_admin/providers/uplata_po_korisniku_provider.dart';
import 'package:flutter/material.dart';
import 'package:erestoran_admin/models/uplata_po_korisniku.dart';

class UplatePoKorisnikuReport extends StatefulWidget {
  @override
  _UplatePoKorisnikuReportState createState() =>
      _UplatePoKorisnikuReportState();
}

class _UplatePoKorisnikuReportState extends State<UplatePoKorisnikuReport> {
  late UplatePoKorisnikuProvider _uplatePoKorisnikuProvider;
  late Future<List<UplataPoKorisniku>> _uplateFuture;

  @override
  void initState() {
    super.initState();
    _uplatePoKorisnikuProvider = UplatePoKorisnikuProvider();
    _uplateFuture = _uplatePoKorisnikuProvider.fetchUplate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uplate po korisniku"),
        backgroundColor: Color.fromARGB(255, 234, 108, 70),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UplataPoKorisniku>>(
        future: _uplateFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Greška: ${snapshot.error}",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Nema podataka za prikaz.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else {
            List<UplataPoKorisniku> uplate = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: uplate.length,
              itemBuilder: (context, index) {
                final uplata = uplate[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${uplata.imeKorisnika} ${uplata.prezimeKorisnika}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Chip(
                              label: Text(
                                uplata.nacinPlacanja ?? "Nepoznato",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color.fromARGB(255, 203, 71, 31),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Iznos: ${uplata.iznos?.toStringAsFixed(2)} KM",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        Text(
                          "Datum: ${uplata.datumTransakcije ?? "Nepoznato"}",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

