import 'dart:convert';

import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/narudzba.dart';
import 'package:erestoran_admin/models/statusNarudzbe.dart';
import 'package:erestoran_admin/models/stavkeNarudzbe.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/providers/narudzbu_provider.dart';
import 'package:erestoran_admin/providers/statusNarudzbe_provider.dart';
import 'package:erestoran_admin/providers/stavkeNarudzbe_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late ProductProvider _jeloProvider;
  late KorisnikProvider _korisnikProvider;
  late NarudzbaProvider _narudzbaProvider;
  late stavkeNarudzbeProvider _stavkeProvider;
  late StatusNarudzbeProvider _statusProvider;
  List<Jelo> jelaList = [];

  SearchResult<Dojmovi>? result;
  Map<String, String> jeloMap = {};
  Map<String, String> korisnikMap = {};
  TextEditingController _nazivController = TextEditingController();
  List<StavkeNarudzbe> stavkeNarudzbe = [];
  List<Narudzba> narudzbeList = [];
  List<StatusNarudzbe> statusList = [];
  Map<int, String> jeloSlikaMap = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dojmoviProvider = context.read<DojmoviProvider>();
    _jeloProvider = context.read<ProductProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _stavkeProvider = context.read<stavkeNarudzbeProvider>();
    _statusProvider = context.read<StatusNarudzbeProvider>();

    _loadData();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      result = await _dojmoviProvider.get();

      var jeloResult = await _jeloProvider.get();
      if (jeloResult?.result != null) {
        jeloMap = {
          for (var jelo in jeloResult!.result)
            jelo.jeloId.toString(): jelo.naziv ?? ''
        };
        jeloSlikaMap = {
          for (var jelo in jeloResult.result) jelo.jeloId!: jelo.slika ?? ''
        };
        jelaList = jeloResult.result; 
      }

      var korisnikResult = await _korisnikProvider.get();
      if (korisnikResult?.result != null) {
        korisnikMap = {
          for (var korisnik in korisnikResult!.result)
            korisnik.id.toString(): korisnik.ime ?? ''
        };
      }

      var narudzbeResult = await _narudzbaProvider.get();
      narudzbeList = narudzbeResult?.result ?? [];

      var stavkeResult = await _stavkeProvider.get();
      stavkeNarudzbe = stavkeResult?.result ?? [];

      var statusResult = await _statusProvider.get();
      statusList = statusResult?.result ?? [];

      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _loadData() async {
    var data =
        await _dojmoviProvider.get(filter: {'naziv': _nazivController.text});
    setState(() {
      result = data;
    });
  }

  String getNarudzbaDatum(Dojmovi dojam) {
    final stavka = stavkeNarudzbe.firstWhere(
      (s) => s.jeloId == dojam.jeloId,
      orElse: () => StavkeNarudzbe(0, 0, 0, 0, 0, 0),
    );

    if (stavka.narudzbaId == null) return "Nepoznat datum";

    final narudzba = narudzbeList.firstWhere(
      (n) => n.id == stavka.narudzbaId,
      orElse: () => Narudzba(0, null, 0, 0, '', ''),
    );

    return narudzba.datumNarudzbe ?? "Nepoznat datum";
  }

  ImageProvider? _imageForJelo(Jelo j) {
    final raw = j.slika;
    if (raw == null || raw.isEmpty) return null;

    if (raw.startsWith('http')) return NetworkImage(raw);

    try {
      final bytes = base64Decode(raw);
      return MemoryImage(bytes);
    } catch (_) {
      return null;
    }
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
    Map<int, Narudzba> narudzbaMap = {for (var n in narudzbeList) n.id!: n};
    Map<int, StatusNarudzbe> statusMap = {for (var s in statusList) s.id!: s};

    String getStatus(Dojmovi dojam) {
      final stavka = stavkeNarudzbe.firstWhere((s) => s.jeloId == dojam.jeloId,
          orElse: () => StavkeNarudzbe(0, 0, 0, 0, 0, 0));

      if (stavka.narudzbaId == null) return "Nepoznat status";

      final narudzba = narudzbaMap[stavka.narudzbaId];
      if (narudzba == null) return "Nepoznat status";

      final status = statusMap[narudzba.statusNarudzbeId];
      return status?.naziv ?? "Nepoznat status";
    }

    Icon getStatusIcon(String status) {
      switch (status) {
        case 'Kreirana':
          return Icon(Icons.create_outlined, color: Colors.grey);
        case 'Prihvaćena':
          return Icon(Icons.check_circle_outline, color: Colors.green);
        case 'U toku':
          return Icon(Icons.autorenew, color: Colors.orange);
        case 'Završena':
          return Icon(Icons.done_all, color: Colors.blue);
        case 'poslano':
          return Icon(Icons.local_shipping, color: Colors.purple);
        default:
          return Icon(Icons.help_outline, color: Colors.black26);
      }
    }

    Color getStatusColor(String status) {
      switch (status) {
        case 'Kreirana':
          return Colors.grey;
        case 'Prihvaćena':
          return Colors.green;
        case 'U toku':
          return Colors.orange;
        case 'Završena':
          return Colors.blue;
        case 'poslano':
          return Colors.purple;
        default:
          return Colors.black26;
      }
    }

    String getNarudzbaDatum(Dojmovi dojam) {
      final stavka = stavkeNarudzbe.firstWhere((s) => s.jeloId == dojam.jeloId,
          orElse: () => StavkeNarudzbe(0, 0, 0, 0, 0, 0));

      if (stavka.narudzbaId == null) return "Nepoznat datum";

      final narudzba = narudzbaMap[stavka.narudzbaId];
      if (narudzba?.datumNarudzbe == null || narudzba!.datumNarudzbe!.isEmpty)
        return "Nepoznat datum";

      try {
        DateTime dt = DateTime.parse(narudzba.datumNarudzbe!);
        return DateFormat('dd.MM.yyyy').format(dt);
      } catch (e) {
        return narudzba.datumNarudzbe!;
      }
    }

    ImageProvider? _imageForJeloId(int jeloId) {
      final slika = jeloSlikaMap[jeloId];
      if (slika == null || slika.isEmpty) return null;

      if (slika.startsWith('http')) return NetworkImage(slika);

      try {
        final bytes = base64Decode(slika);
        return MemoryImage(bytes);
      } catch (_) {
        return null;
      }
    }

    final scaffoldContext = context; 

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: result?.result.map((Dojmovi e) {
                  String nazivJela =
                      jeloMap[e.jeloId.toString()] ?? 'Nepoznato';
                  String imeKorisnika =
                      korisnikMap[e.korisnikId.toString()] ?? 'Nepoznato';
                  String statusNaziv = getStatus(e);
                  Icon statusIcon = getStatusIcon(statusNaziv);
                  String datumNarudzbe = getNarudzbaDatum(e);
                  ImageProvider? imgProvider = _imageForJeloId(e.jeloId!);

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: imgProvider != null
                                ? Image(
                                    image: imgProvider,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (c, e, s) => const Center(
                                      child: Icon(Icons.broken_image,
                                          size: 40, color: Colors.orange),
                                    ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.fastfood,
                                        size: 40, color: Colors.orange),
                                  ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < (e.ocjena?.round() ?? 0)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.orange[700],
                                      size: 20,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 4),
                                Text('Opis: ${e.opis ?? "Nema opisa"}',
                                    style: TextStyle(color: Colors.black54)),
                                const SizedBox(height: 4),
                                Text('Jelo: $nazivJela',
                                    style: TextStyle(color: Colors.black54)),
                                const SizedBox(height: 4),
                                Text('Korisnik: $imeKorisnika',
                                    style: TextStyle(color: Colors.black54)),
                                const SizedBox(height: 4),
                                Text('Datum narudžbe: $datumNarudzbe',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              statusIcon,
                              const SizedBox(height: 8),
                              Text(
                                statusNaziv,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: getStatusColor(statusNaziv),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              IconButton(
                                icon: Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: Text("Potvrda brisanja"),
                                        content: Text(
                                            "Da li želite obrisati ovaj dojam?"),
                                        actions: [
                                          TextButton(
                                            child: Text("Otkaži"),
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Obriši",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            onPressed: () async {
                                              try {
                                                await _dojmoviProvider
                                                    .delete(e.id!);

                                                Navigator.of(dialogContext)
                                                    .pop();
                                                _loadData();

                                                ScaffoldMessenger.of(
                                                        scaffoldContext)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Obrisali ste dojam"),
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              } catch (err) {
                                                print(
                                                    "Greška prilikom brisanja: $err");
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
