import 'package:erestoran_admin/main.dart';
import 'package:erestoran_admin/screens/dojmovi_list_screen.dart';
import 'package:erestoran_admin/screens/home_screen.dart';
import 'package:erestoran_admin/screens/izvjestaj_o_prometu_po_korisniku.dart';
import 'package:erestoran_admin/screens/izvjestaj_o_prometu_screen.dart';
import 'package:erestoran_admin/screens/kategorija_screen.dart';
import 'package:erestoran_admin/screens/korisnik_profile_screen.dart';
import 'package:erestoran_admin/screens/meni_screen.dart';
import 'package:erestoran_admin/screens/narudzbe_list_screen.dart';
import 'package:erestoran_admin/screens/product_detail_screen.dart';
import 'package:erestoran_admin/screens/status_narudzba_screen.dart';
import 'package:flutter/material.dart';
import 'package:erestoran_admin/screens/product_list_screen.dart';
import 'package:erestoran_admin/screens/grad_detail_screen.dart';
import 'package:erestoran_admin/screens/grad_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  final String? activeItem;
  MasterScreenWidget(
      {this.child, this.title, this.title_widget, this.activeItem, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  late String _activeItem;

  @override
  void initState() {
    super.initState();
    _activeItem = widget.activeItem ?? "Home";
  }

  Widget _buildNavBarItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavText(context, "Home", HomeScreen()),
        _buildNavText(context, "Meni", MeniScreen()),
        _buildNavText(context, "Status narudzbe", StatusNarudzbaScreen()),
        _buildNavText(
            context, "Evidencija obavjestenja", StatusNarudzbaScreen()),
        _buildNavText(context, "Dojmovi", DojmoiListScreen()),
        _buildNavText(context, "Users", KorisnikScreen()),
      ],
    );
  }

  Widget _buildNavText(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        onHover: (isHovered) {
          setState(() {});
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() {});
          },
          onExit: (_) {
            setState(() {});
          },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        automaticallyImplyLeading: false,
        title: Text(
          widget.title ?? "",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => KorisnikScreen()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            color: const Color.fromARGB(255, 23, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildSidebarItem(context, "Home", HomeScreen(), Icons.home),
                _buildSidebarItem(
                    context, "Meni", MeniScreen(), Icons.restaurant_menu),
                _buildSidebarItem(context, "Evidencija narudžbe",
                    StatusNarudzbaScreen(), Icons.assignment),
                _buildSidebarItem(context, "Evidencija obavjestenja",
                    StatusNarudzbaScreen(), Icons.notifications),
                _buildSidebarItem(
                    context, "Dojmovi", DojmoiListScreen(), Icons.comment),
                _buildSidebarItem(
                    context, "Users", KorisnikScreen(), Icons.people),
              ],
            ),
          ),
          Expanded(
            child: widget.child ?? Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
      BuildContext context, String title, Widget screen, IconData icon) {
    final bool isActive = _activeItem == title;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MasterScreenWidget(
              child: screen,
              title: title,
              activeItem: title, 
            ),
          ),
        );
      },
      child: Container(
        color: isActive ? Colors.orange : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.black : Colors.orange,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.black : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
