import 'package:erestoran_admin/providers/dojmovi_provider.dart';
import 'package:erestoran_admin/providers/grad_provider.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/providers/narudzbu_provider.dart';
import 'package:erestoran_admin/providers/statusNarudzbe_provider.dart';
import 'package:erestoran_admin/providers/stavkeNarudzbe_provider.dart';
import 'package:erestoran_admin/providers/uloga_provider.dart';
import 'package:erestoran_admin/screens/home_screen.dart';
import 'package:erestoran_admin/screens/korisnik_profile_screen.dart';
import 'package:erestoran_admin/screens/product_list_screen.dart';
import 'package:erestoran_admin/screens/status_narudzba_screen.dart';
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
    ChangeNotifierProvider(create: (_)=> DojmoviProvider()),
    ChangeNotifierProvider(create: (_)=> UlogaProvider()),
    ChangeNotifierProvider(create: (_)=> StatusNarudzbeProvider()),







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

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KorisnikScreen(),
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
/*
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Admin!"),
        ),
        body: 
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 400, maxHeight: 500),
              child: Container(
                color:
                    const Color.fromARGB(255, 202, 202, 202).withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.asset(
                       "assets/images/slika1.jpg",
                        height: 200,
                        width: 300,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0x298031CC),
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
                          color: Color(0x298031CC),
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );*/

      return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
                      "Welcome Back!",
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
                      "Login to your account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black54),
                        prefixIcon: Icon(Icons.account_circle, color: Colors.orange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                      ),
                      controller: _usernameController,
                    ),
                    SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black54),
                        prefixIcon: Icon(Icons.lock, color: Colors.orange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
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
                                "Login",
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