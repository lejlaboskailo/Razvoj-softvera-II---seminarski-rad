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
   MasterScreenWidget({this.child, this.title, this.title_widget, super.key});
 
  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}


 
class _MasterScreenWidgetState extends State<MasterScreenWidget> {

  Widget _buildNavBarItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavText(context, "Home", HomeScreen()),
        _buildNavText(context, "Meni", MeniScreen()),
        _buildNavText(context, "Status narudzbe", StatusNarudzbaScreen()),
        _buildNavText(context, "Evidencija obavjestenja", StatusNarudzbaScreen()),
        _buildNavText(context, "Dojmovi", DojmoiListScreen()),
       // _buildNavText(context, "Reports", UplatePoKorisnikuReport()),
       // _buildNavText(context, "Reports", PrometPoKorisnikuReport()),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.orange,
        automaticallyImplyLeading: false,
        title: 
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
        actions: [
          _buildNavBarItems(context),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: widget.child!),
        ],
      ),
    );
  }
}