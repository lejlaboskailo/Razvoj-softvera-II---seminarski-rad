import 'package:erestoran_admin/providers/dojmovi_provider.dart';
import 'package:erestoran_admin/providers/grad_provider.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/providers/narudzbu_provider.dart';
import 'package:erestoran_admin/providers/restoran_provider.dart';
import 'package:erestoran_admin/providers/statusNarudzbe_provider.dart';
import 'package:erestoran_admin/providers/stavkeNarudzbe_provider.dart';
import 'package:erestoran_admin/providers/uloga_provider.dart';
import 'package:erestoran_admin/screens/home_screen.dart';
import 'package:erestoran_admin/screens/korisnik_profile_screen.dart';
import 'package:erestoran_admin/screens/product_list_screen.dart';
import 'package:erestoran_admin/screens/status_narudzba_screen.dart';
import 'package:erestoran_admin/utils/util.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GradProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => KategorijaProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => KategorijaProvider()),
      ChangeNotifierProvider(create: (_) => stavkeNarudzbeProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbaProvider()),
      ChangeNotifierProvider(create: (_) => DojmoviProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
      ChangeNotifierProvider(create: (_) => StatusNarudzbeProvider()),
      ChangeNotifierProvider(create: (_) => RestoranProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
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
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late KorisnikProvider _korisnikProvider;
  int? loggedInUserID;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    var username = _usernameController.text;
    var password = _passwordController.text;

    Authorization.username = username;
    Authorization.password = password;

    try {
      Authorization.korisnik = await _korisnikProvider.Authenticate();

      if (Authorization.korisnik?.korisniciUloges
              .any((role) => role.uloga?.naziv == "Admin") ==
          true) {
        setState(() {
          loggedInUserID = Authorization.korisnik?.id;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MasterScreenWidget(
              child: HomeScreen(),
              title: "Početna",
              activeItem: "Početna",
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(
                "Vaš korisnički račun nema permisije za pristup admin panelu!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Pogrešno korisničko ime ili lozinka!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = context.read<KorisnikProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Prijavi se"),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/slika1.jpg"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Dobrodošli!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prijavi se na svoj račun!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Korisničko ime",
                      labelStyle: TextStyle(color: Colors.black54),
                      prefixIcon:
                          Icon(Icons.account_circle, color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Lozinka",
                      labelStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 32),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Prijavi se",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
