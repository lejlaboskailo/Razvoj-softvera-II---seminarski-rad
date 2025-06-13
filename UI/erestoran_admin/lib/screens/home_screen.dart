import 'package:erestoran_admin/models/grad.dart';
import 'package:erestoran_admin/models/restoran.dart';
import 'package:erestoran_admin/models/search_result.dart';
import 'package:erestoran_admin/providers/grad_provider.dart';
import 'package:erestoran_admin/providers/restoran_provider.dart';
import 'package:erestoran_admin/screens/izvjestaj_o_prometu_po_korisniku.dart';
import 'package:erestoran_admin/screens/izvjestaj_o_prometu_screen.dart';
import 'package:erestoran_admin/screens/meni_screen.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RestoranProvider _restoranProvider;
  late GradProvider _gradProvider;

  SearchResult<Restoran>? restoran;
  SearchResult<Grad>? grad;

  final _nazivController = TextEditingController();
  final _adresaController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonController = TextEditingController();
  int? _selectedGradId;

  @override
  void dispose() {
    _nazivController.dispose();
    _adresaController.dispose();
    _emailController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _restoranProvider = context.read<RestoranProvider>();
    _gradProvider = context.read<GradProvider>();

    _loadData();
    _loadGrad();
  }

  Future<void> _loadData() async {
    var data = await _restoranProvider.get();
    setState(() {
      restoran = data;
    });
  }

  Future<void> _loadGrad() async {
    var data = await _gradProvider.get();
    setState(() {
      grad = data;
    });
  }

  String getGradNaziv(int? gradId) {
    if (grad == null || grad!.result.isEmpty || gradId == null) return 'N/A';

    var gradObj = grad!.result.firstWhere(
      (g) => g.id == gradId,
    );

    return gradObj.naziv ?? 'N/A';
  }

  void _showEditDialog(Restoran restoranData) {
    _nazivController.text = restoranData.nazivRestorana ?? '';
    _adresaController.text = restoranData.adresa ?? '';
    _emailController.text = restoranData.email ?? '';
    _telefonController.text = restoranData.telefon ?? '';
    _selectedGradId = restoranData.gradId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Uredi podatke o restoranu'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nazivController,
                decoration: InputDecoration(labelText: 'Naziv restorana'),
              ),
              TextField(
                controller: _adresaController,
                decoration: InputDecoration(labelText: 'Adresa'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _telefonController,
                decoration: InputDecoration(labelText: 'Telefon'),
              ),
              DropdownButtonFormField<int>(
                value: _selectedGradId,
                items: grad?.result
                    .map((g) => DropdownMenuItem<int>(
                          value: g.id,
                          child: Text(g.naziv ?? ''),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedGradId = val;
                  });
                },
                decoration: InputDecoration(labelText: 'Grad'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Otkaži'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Spasi'),
            onPressed: () async {
              restoranData.nazivRestorana = _nazivController.text;
              restoranData.adresa = _adresaController.text;
              restoranData.email = _emailController.text;
              restoranData.telefon = _telefonController.text;
              restoranData.gradId = _selectedGradId;

              await _restoranProvider.update(
                  restoranData.restoranId!, restoranData);
              await _loadData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/home.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
                right: 300),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        _buildMeniCard(),
                        SizedBox(height: 20),
                        _buildIzvjestajCards(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 30,
            right: 20,
            width: 280,
            child: _buildLargeCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeCard() {
    return Card(
      color: const Color.fromARGB(255, 18, 18, 18).withOpacity(0.95),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kontakt informacije',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800]),
                ),
              ],
            ),
            Divider(height: 30, thickness: 2, color: Colors.orange[200]),
            if (restoran != null && restoran!.result.isNotEmpty)
              Column(
                children: [
                  _buildContactRow(Icons.store, 'Naziv:',
                      restoran!.result.first.nazivRestorana ?? 'N/A'),
                  _buildContactRow(Icons.location_on, 'Adresa:',
                      restoran!.result.first.adresa ?? 'N/A'),
                  _buildContactRow(Icons.email, 'Email:',
                      restoran!.result.first.email ?? 'N/A'),
                  _buildContactRow(Icons.phone, 'Telefon:',
                      restoran!.result.first.telefon ?? 'N/A'),
                  _buildContactRow(Icons.location_city, 'Grad:',
                      getGradNaziv(restoran!.result.first.gradId)),
                ],
              )
            else
              Center(child: CircularProgressIndicator()),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              icon: Icon(Icons.edit, size: 18, color: Colors.white,),
              label: Text('Uredi', style: TextStyle(color: Colors.white), ),
              onPressed: () {
                _showEditDialog(restoran!.result.first);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dobrodošli na eRestoran Admin početnu stranicu!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Ovo je centralno mesto za upravljanje aplikacijom. Pregledajte narudžbe, korisnike i ostale funkcionalnosti.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String value}) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeniCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MeniScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange[100],
                    ),
                    child: Center(
                      child:
                          Icon(Icons.menu_book, size: 70, color: Colors.orange),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Meni",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIzvjestajCards() {
    return SizedBox(
      width: 520,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSingleIzvjestajCard(
            title: 'Uplate po korisniku',
            icon: Icons.attach_money,
            iconColor: Colors.green,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => UplatePoKorisnikuReport()),
              );
            },
          ),
          SizedBox(width: 16),
          _buildSingleIzvjestajCard(
            title: 'Promet po korisniku',
            icon: Icons.bar_chart,
            iconColor: Colors.blue,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PrometPoKorisnikuReport()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSingleIzvjestajCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 250,
      height: 160,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(icon, size: 70, color: iconColor),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange[600], size: 28),
          SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.orange, fontSize: 16),
                children: [
                  TextSpan(
                      text: '$label ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
