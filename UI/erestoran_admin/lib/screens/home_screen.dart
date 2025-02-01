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
  Future<void> _loadGrad()async{
    var data=await  _gradProvider.get();
    setState(() {
      grad=data;
    });
  }

  String getGradNaziv(int? gradId) {
  if (grad == null || grad!.result.isEmpty || gradId == null) return 'N/A';

  var gradObj = grad!.result.firstWhere(
    (g) => g.id == gradId,
  );

  return gradObj.naziv ?? 'N/A';
}


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/home.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildWelcomeCard(),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          _buildMeniCard(),
                          _buildIzvjestajCard(),
                          Expanded(
                            child: _buildLargeCard(),
                          ),
                          SizedBox(width: 16),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
  return SizedBox(
    width: 250, // Postavi željenu širinu
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Postavi na 1 ako želiš samo jednu veliku karticu
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orange[100],
                        ),
                        child: Center(
                          child: Icon(Icons.menu_book, size: 70, color: Colors.orange), // Povećana ikona
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center( // Centriran tekst
                      child: Text(
                        "Meni",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget _buildIzvjestajCard() {
  return SizedBox(
    width: 300,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Postavi na 1 ako želiš samo jednu veliku karticu
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemCount: 1, // Samo jedna kartica za izvještaje
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => UplatePoKorisnikuReport()),
                      );
                    },
                    child: Text(
                      'Pregled uplata po korisniku',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  // Link za drugi izvještaj
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PrometPoKorisnikuReport()), // Zamijeni s pravom stranicom
                      );
                    },
                    child: Text(
                      'Promet po korisniku',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}




  Widget _buildLargeCard() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Card(
          color: Colors.white.withOpacity(0.8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informations:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                if (restoran != null && restoran!.result.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text('Naziv: ${restoran!.result.first.nazivRestorana ?? 'N/A'}'),
                      Text('Adresa: ${restoran!.result.first.adresa ?? 'N/A'}'),
                      Text('Email: ${restoran!.result.first.email ?? 'N/A'}'),
                      Text(
                          'Telefon: ${restoran!.result.first.telefon ?? 'N/A'}'),
                      
                     Text('Grad: ${getGradNaziv(restoran!.result.first.gradId)}'),

                    ],
                  )
                else
                  Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
