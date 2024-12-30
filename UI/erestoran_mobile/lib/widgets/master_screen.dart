import 'package:erestoran_mobile/main.dart';
import 'package:erestoran_mobile/models/dojmovi.dart';
import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/screens/dojmovi_list_screen.dart';
import 'package:erestoran_mobile/screens/home_screen.dart';
import 'package:erestoran_mobile/screens/korisnik_profile_screen.dart';
import 'package:erestoran_mobile/screens/meni_screen.dart';
import 'package:erestoran_mobile/screens/preporuceni_screen.dart';
import 'package:erestoran_mobile/utils/util.dart';
import 'package:flutter/material.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  MasterScreenWidget({this.child, this.title, this.title_widget,super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {

  void _logout() {
    Authorization.korisnik = null;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
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
                    builder: (context) => PreporucenaJelaScreen(korisnikId: 1002)));
              },
            ),
             ListTile(
              title: const Text("Ostavi ocjenu"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  DojmoviDetailsScreen()));
              },
            ),
            ListTile(
              title: const Text("Odjavi se"),
              onTap: () {
                _logout(); 
              },
            )
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
