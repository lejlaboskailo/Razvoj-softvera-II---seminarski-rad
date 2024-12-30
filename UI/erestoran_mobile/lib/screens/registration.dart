import 'package:erestoran_mobile/models/korisnik_uloga.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
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
    _imecontroller=TextEditingController();
    _prezimeController=TextEditingController();

  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _imecontroller.dispose();
    _prezimeController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _korisnikProvider = context.read<KorisnikProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Registracija korisnika!"),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              /*child: Image.asset(
                "assets/images/welcomepage.jpg",
                fit: BoxFit.cover,
              ),*/
            ),
          ),
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
                        "assets/images/logo.jpg",
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
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0x298031CC),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Ime",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon:
                                Icon(Icons.account_circle, color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                          controller: _imecontroller,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0x298031CC),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Prezime",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon:
                                Icon(Icons.account_circle, color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                          controller: _prezimeController,
                        ),
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : 
                          ElevatedButton(
                            onPressed: _register, 
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }


 Future<void> _register() async {
  setState(() {
    _isLoading = true;
  });

  var username = _usernameController.text;
  var password = _passwordController.text;
  var ime = _imecontroller.text;
  var prezime = _prezimeController.text;

  if (username.isEmpty || password.isEmpty || ime.isEmpty || prezime.isEmpty) {
    setState(() {
      _isLoading = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Greška"),
          content: Text("Svi podaci moraju biti popunjeni."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
    return;
  }

  try {
    var korisnik = await _korisnikProvider.Register(
      username: username,
      password: password,
      ime: ime,
      prezime: prezime,
      korisniciUloges: [
        KorisnikUloga(korisnikUlogaId: 2, ulogaId: 2), 
      ],
    );
  } catch (e) {
    print("Greška tokom registracije: $e");
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

}