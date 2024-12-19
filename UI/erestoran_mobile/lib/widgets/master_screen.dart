import 'package:erestoran_mobile/screens/home_screen.dart';
import 'package:flutter/material.dart';

 
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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
             /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => KorisnikScreen()
                  )
                );
              print("Login button pressed");*/
            },
          ),
        ],        
      ),
      
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("<-"),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Home screen"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()
                  )
                );
              },
            ),
            ListTile(
              title: const Text("Meni"),
              onTap: (){
               /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MeniScreen()
                  )
                );*/
              },
            ),
          ],
        ),
      ),
      
      body: widget.child,
    );
  }
}