import 'package:erestoran_admin/providers/grad_provider.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/providers/narudzbu_provider.dart';
import 'package:erestoran_admin/providers/stavkeNarudzbe_provider.dart';
import 'package:erestoran_admin/screens/product_list_screen.dart';
import 'package:erestoran_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> GradProvider()),
    ChangeNotifierProvider(create: (_)=> ProductProvider()),
    ChangeNotifierProvider(create: (_)=> KategorijaProvider()),
    ChangeNotifierProvider(create: (_)=> KorisnikProvider()),
    ChangeNotifierProvider(create: (_)=> KategorijaProvider()),
    ChangeNotifierProvider(create: (_)=> stavkeNarudzbeProvider()),
    ChangeNotifierProvider(create: (_)=> NarudzbaProvider()),





  ],
    child: const MyApp(),
  ));
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyMaterialApp(),
    );
  }
}
 
class MyAppBar extends StatelessWidget {
  String? title;
  MyAppBar({Key? key, required this.title}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Text(title!);
  }
}
 
class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);
 
  @override
  State<Counter> createState() => _CounterState();
}
 
class _CounterState extends State<Counter> {
  int _count = 0;
  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('You have pushed button $_count times.'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text("Increment++"),
        )
      ],
    );
  }
}
 
class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RS II Material App",
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the KorisnikProvider instance from the context
    final korisnikProvider = Provider.of<KorisnikProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset("assets/images/slika1.jpg", width: 100, height: 100),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Username", prefixIcon: Icon(Icons.email)),
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.password)),
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        var username = _usernameController.text;
                        var password = _passwordController.text;

                        print("login proceed $username $password");

                        Authorization.username = username;
                        Authorization.password = password;

                        try {
                          await korisnikProvider.get();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ProductListScreen()),
                          );
                        } on Exception catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Error"),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text("Login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  } 
}
 