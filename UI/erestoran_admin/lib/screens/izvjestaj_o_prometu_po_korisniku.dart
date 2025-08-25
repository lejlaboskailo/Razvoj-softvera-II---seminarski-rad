import 'dart:io';

import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:erestoran_admin/providers/promet_po_korisniku_provider.dart';
import 'package:erestoran_admin/models/promet_po_korisniku.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrometPoKorisnikuReport extends StatefulWidget {
  @override
  _PrometPoKorisnikuReportState createState() =>
      _PrometPoKorisnikuReportState();
}

class _PrometPoKorisnikuReportState extends State<PrometPoKorisnikuReport> {
  late Future<List<PrometPoKorisniku>> _prometFuture;
  final PrometPoKorisnikuProvider _provider = PrometPoKorisnikuProvider();

  @override
  void initState() {
    super.initState();
    _prometFuture = _provider.fetchPromet();
  }

  Future<void> _generatePdf(List<PrometPoKorisniku> promet) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Promet po korisnicima',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              ...promet.map((item) {
                return pw.Text(
                  'Korisnik: ${item.imeKorisnika ?? "Nepoznato"}\n'
                  'Datum narudzbe: ${item.datumNarudzbe ?? "Nepoznato"}\n'
                  'Kategorija: ${item.nazivKategorije ?? "Nepoznato"}\n'
                  '---------------------------------------------------',
                  style: pw.TextStyle(fontSize: 12),
                );
              }).toList(),
            ],
          );
        },
      ),
    );

    try {
      final outputDir = await getApplicationDocumentsDirectory();
      final filePath = '${outputDir.path}/promet_po_korisnicima.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      print('PDF spremljen na $filePath');

      _showReportDownloadedDialog(filePath);
    } catch (e) {
      print('Greška: $e');
    }
  }

  void _showReportDownloadedDialog(String filePath) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Izveštaj preuzet'),
          content: Text('Izveštaj je preuzet i sačuvan na:\n$filePath'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
       child: Container(
      color: const Color.fromARGB(255, 232, 198, 148),
      child: FutureBuilder<List<PrometPoKorisniku>>(
        future: _prometFuture,
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
            final promet = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _generatePdf(promet);
                    },
                    icon: Icon(Icons.download),
                    label: Text("Preuzmi PDF izveštaj", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.orange,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: promet.length,
                    itemBuilder: (context, index) {
                      final item = promet[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            item.imeKorisnika ?? "Nepoznato",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            "Datum: ${item.datumNarudzbe ?? "Nepoznato"}\n"
                            "Kategorija: ${item.nazivKategorije ?? "Nepoznato"}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          leading: Icon(
                            Icons.person,
                            color: const Color.fromARGB(255, 223, 88, 48),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    ),);
  }
}
