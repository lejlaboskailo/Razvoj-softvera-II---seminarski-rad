import 'package:erestoran_admin/screens/meni_screen.dart';
import 'package:erestoran_admin/screens/product_list_screen.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {

 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildWelcomeCard(),
                      SizedBox(height: 44), // Razmak između kartice i dugmeta
                    Center(
                      child: Container(
                        width: double.infinity, // Proširuje dugme do ivica
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 25.0), // Povećava visinu dugmeta
                            backgroundColor: Colors.white.withOpacity(0.8), // Boja dugmeta s prozirnošću
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MeniScreen(),
                              ),
                            );
                            // Akcija koju želite izvršiti kada dugme bude pritisnuto
                            print("Dugme je pritisnuto!");
                          },
                          child: Text(
                            "Go to Meni", // Tekst na dugmetu
                            style: TextStyle(color: Colors.black), // Promjena boje teksta na crnu
                          ),
                        ),
                      ),
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
      color: Colors.white.withOpacity(0.8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dobrodošli na eRestoran Admin početnu stranicu!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Od tradicionalnih specijaliteta do modernih gastronomskih kreacija, naš meni je osmišljen da zadovolji sve ukuse. Brza i jednostavna online narudžba omogućava vam da uživate u omiljenim jelima iz udobnosti vašeg doma. Uz brzu dostavu, vaša hrana stiže topla i spremna za uživanje.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
 
 
}