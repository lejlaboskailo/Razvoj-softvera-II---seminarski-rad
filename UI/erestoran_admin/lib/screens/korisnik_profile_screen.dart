import 'package:erestoran_admin/main.dart';
import 'package:erestoran_admin/models/korisnik.dart';
import 'package:erestoran_admin/models/search_result.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/screens/korisnik_details_screen.dart';
import 'package:erestoran_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KorisnikScreen extends StatefulWidget {
  const KorisnikScreen({Key? key}) : super(key: key);

  @override
  State<KorisnikScreen> createState() => _KorisnikScreen();
}

class _KorisnikScreen extends State<KorisnikScreen> {
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? result;
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  String? _successMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _fetchKorisnici();
  }

  Future<void> _fetchKorisnici() async {
    var data = await _korisnikProvider.get();
    setState(() {
      result = SearchResult<Korisnik>(
        result: data.result.where((korisnik) {
          return korisnik.korisniciUloges.any((uloga) => uloga.ulogaId == 1);
        }).toList(),
        count: data.count,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final korisnik = result?.result.first;

    return Scaffold(
      body: korisnik != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${korisnik.ime ?? ''} ${korisnik.prezime ?? ''}",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 16),
                          _buildProfileDetail("Korisnicko ime",
                              korisnik.korisnickoIme ?? "", Icons.person),
                          SizedBox(height: 24),
                          _buildProfileDetail(
                              "Telefon", korisnik.telefon ?? "", Icons.phone),
                          SizedBox(height: 24),
                          _buildProfileDetail(
                              "Email", korisnik.email ?? "", Icons.email),
                          SizedBox(height: 24),
                          
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final changed =
                                  await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
                                  builder: (_) => KorisniciDetailsScreen(
                                      korisnik: korisnik),
                                ),
                              );

                              if (changed == true) {
                                await _fetchKorisnici(); 
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 146, 89, 3)),
                            child: const Text("Uredi",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }



  Widget _buildProfileDetail(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            SizedBox(width: 16),
            Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
