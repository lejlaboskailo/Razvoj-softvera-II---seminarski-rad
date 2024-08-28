import 'package:erestoran_admin/main.dart';
import 'package:erestoran_admin/screens/kategorija_screen.dart';
import 'package:erestoran_admin/screens/narudzbe_list_screen.dart';
import 'package:erestoran_admin/screens/product_detail_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title_widget ?? Text(widget.title ?? ""),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("<-"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  LoginPage()
                  )
                );
              },
            ),
            ListTile(
              title: const Text("Meni"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProductListScreen()
                  )
                );
              },
            ),
            ListTile(
              title: const Text("Vrste jela"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  KategorijaListScreen()
                  )
                );
              },
            ),
             ListTile(
              title: const Text("Narudzbe"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  NarudzbaListScreen()
                  )
                );
              },
            )
          ],
        ),
      ),
      body: widget.child,
    );
  }
}