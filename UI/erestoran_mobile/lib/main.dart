import 'package:erestoran_mobile/providers/dojmovi_provider.dart';
import 'package:erestoran_mobile/providers/kategorija_provider.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:erestoran_mobile/providers/meni_provider.dart';
import 'package:erestoran_mobile/providers/uloga_provider.dart';
import 'package:erestoran_mobile/screens/home_screen.dart';
import 'package:erestoran_mobile/screens/registration.dart';
import 'package:erestoran_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
      ChangeNotifierProvider(create: (_) => MeniProvider()),
      ChangeNotifierProvider(create: (_) => KategorijaProvider()),
      ChangeNotifierProvider(create: (_) => DojmoviProvider()),


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
      home: LoginPage(),
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
  late TextEditingController _imecontroller;
  late TextEditingController _prezimeController;
  late KorisnikProvider _korisnikProvider;
  int? loggedInUserID;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _imecontroller = TextEditingController();
    _prezimeController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _imecontroller.dispose();
    _prezimeController.dispose();
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
              ?.any((role) => role.uloga?.naziv == "Korisnik") ==
          true) {
        setState(() {
          loggedInUserID = Authorization.korisnik?.id;
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(
                "Vaš korisnički račun nema permisije za pristup korisnik panelu!"),
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
        title: Text("Login korisnika!"),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              "assets/images/tan.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 500),
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/loggoo.jpg",
                      height: 200,
                      width: 300,
                      
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(41, 199, 135, 93),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon:
                              Icon(Icons.account_circle, color: Colors.black),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                        ),
                        controller: _usernameController,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(41, 199, 135, 93),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon:
                              Icon(Icons.password, color: Colors.black),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                        ),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                    SizedBox(height: 10), 
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistracijaPage()),
                        );
                      },
                      child: Text(
                        "Nemate račun? Registrujte se!",
                        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
