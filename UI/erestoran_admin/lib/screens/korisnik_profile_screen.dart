import 'package:erestoran_admin/main.dart';
import 'package:erestoran_admin/models/korisnik.dart';
import 'package:erestoran_admin/models/search_result.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/screens/home_screen.dart';
import 'package:erestoran_admin/utils/util.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
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

    return MasterScreenWidget(
      title_widget: Text(
        "Hello, Admin! Welcome to your profile!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: korisnik != null
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
                                  Text(
                                    korisnik.korisnickoIme ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(height: 16),
                          _buildProfileDetail("Username",
                              korisnik.korisnickoIme ?? "", Icons.person),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _logout,
                            child: Text("Logout",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          ),
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

  void _logout() {
    Authorization.korisnik = null;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
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
            Icon(icon, color: Colors.blueAccent, size: 28),
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