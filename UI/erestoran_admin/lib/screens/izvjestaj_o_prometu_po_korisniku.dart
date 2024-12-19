import 'dart:io';

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
              pw.Text('Promet po korisnicima', style: pw.TextStyle(fontSize: 24)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Promet po korisnicima"),
      ),
      body: FutureBuilder<List<PrometPoKorisniku>>(
        future: _prometFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Greška: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nema podataka za prikaz."));
          } else {
            final promet = snapshot.data!;
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _generatePdf(promet); // Poziva funkciju za generisanje PDF-a
                  },
                  child: Text("Prezumi PDF izveštaj"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: promet.length,
                    itemBuilder: (context, index) {
                      final item = promet[index];
                      return ListTile(
                        title: Text(item.imeKorisnika ?? "Nepoznato"),
                        subtitle: Text(
                            "Datum: ${item.datumNarudzbe ?? "Nepoznato"} | Kategorija: ${item.nazivKategorije ?? "Nepoznato"}"),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
