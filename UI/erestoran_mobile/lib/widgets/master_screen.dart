import 'package:badges/badges.dart';
import 'package:erestoran_mobile/main.dart';
import 'package:erestoran_mobile/models/dojmovi.dart';
import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/screens/cart_screen.dart';
import 'package:erestoran_mobile/screens/dojmovi_list_screen.dart';
import 'package:erestoran_mobile/screens/home_screen.dart';
import 'package:erestoran_mobile/screens/korisnik_profile_screen.dart';
import 'package:erestoran_mobile/screens/meni_screen.dart';
import 'package:erestoran_mobile/screens/preporuceni_screen.dart';
import 'package:badges/badges.dart' as custom_badges;

import 'package:flutter/material.dart';

/*class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  MasterScreenWidget({this.child, this.title, this.title_widget,super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {

  /*void _logout() {
    Authorization.korisnik = null;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title_widget ?? Text(widget.title ?? ""),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => KorisnikProfileScreen()));
              print("Login button pressed");
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("<-"),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Home screen"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              title: const Text("Meni"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MeniScreen()));
              },
            ),
            ListTile(
              title: const Text("Preporucena jela"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecommendedJeloScreen()));
              },
            ),
             ListTile(
              title: const Text("Ostavi ocjenu"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  DojmoviDetailsScreen()));
              },
            ),
           /* ListTile(
              title: const Text("Odjavi se"),
              onTap: () {
                _logout(); 
              },
            )*/
          ],
        ),
      ),
      body: widget.child,
    );
  }
}*/
class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  int _selectedIndex = 0;

  int _cartItemCount = 3;

  final List<Widget> _mainScreens = [
    HomeScreen(),
    MeniScreen(),
    RecommendedJeloScreen(),
    CartScreen(),
  ];

  final Map<String, Widget> _moreOptions = {
    'Reviews': DojmoviDetailsScreen(),
    //'Contact': BolnicaScreen(),
    //'Online paymant': PaymentDetailsScreen(paymentIntentId: "",),
  };

  void _onMainItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => _mainScreens[index]),
      );
    });
  }

  void _onMoreOptionSelected(String key) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => _moreOptions[key]!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:const Color.fromARGB(255, 184, 178, 60),
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => KorisnikProfileScreen(),
                ),
              );
            },
          ),
          custom_badges.Badge(
            badgeContent: Text(
              '$_cartItemCount', 
              style: TextStyle(color: Colors.white),
            ),
            badgeColor: Colors.red,  
            position: BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              icon: const Icon(Icons.shopping_basket),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: widget.child ?? _mainScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onMainItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Meni',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Recommended Meal',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: _onMoreOptionSelected,
              itemBuilder: (BuildContext context) {
                return _moreOptions.keys
                    .map(
                      (String key) => PopupMenuItem<String>(
                        value: key,
                        child: Text(key),
                      ),
                    )
                    .toList();
              },
            ),
            label: 'More',
          ),
        ],
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
      ),
    );
  }
}
