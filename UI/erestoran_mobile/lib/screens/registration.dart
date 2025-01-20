import 'dart:convert';
import 'dart:io';

import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class RegistracijaPage extends StatefulWidget {
  const RegistracijaPage({Key? key}) : super(key: key);

  @override
  State<RegistracijaPage> createState() => _RegistracijaPageState();
}

class _RegistracijaPageState extends State<RegistracijaPage> {
  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  final TextEditingController spolController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresaController = TextEditingController();
  final TextEditingController korisnickoImeController = TextEditingController();
  final TextEditingController lozinkaController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  bool isLoading = true;
  Korisnik? korisnik;
  late KorisnikProvider _korisniciProvider;
  DateTime? _selectedDate;
  final FocusNode _imeFocusNode = FocusNode();
  final FocusNode _prezimeFocusNode = FocusNode();
  final FocusNode _telefonFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _adresaFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _lozinkaFocusNode = FocusNode();
  bool usernameTaken = false;
  String? _selectedSpol;
  List<String> spolovi = [];

  @override
  void initState() {
    super.initState();
    _korisniciProvider = context.read<KorisnikProvider>();
    initForm();
  }

  @override
  void dispose() {
    _imeFocusNode.dispose();
    _prezimeFocusNode.dispose();
    _telefonFocusNode.dispose();
    _emailFocusNode.dispose();
    _telefonFocusNode.dispose();
    _usernameFocusNode.dispose();
    _lozinkaFocusNode.dispose();
    super.dispose();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> provjeriUsername(String username) async {
    try {
      var temp = await _korisniciProvider
          .get(filter: {"korisnickoIme": username, "admin": true});
      if (mounted) {
        setState(() {
          usernameTaken = temp.count > 0;
        });
      }
    } catch (e) {
      print('Greška pri provjeri username-a: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Registracija",
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [isLoading ? Container() : _addForm()],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _addForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_imeFocusNode);
    });

    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SizedBox(
                height: 550,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                        name: "ime",
                        focusNode: _imeFocusNode,
                        controller: imeController,
                        decoration: const InputDecoration(labelText: "Ime"),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_prezimeFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno!';
                          } else if (!RegExp(r'^[A-Z-ŠĐČĆŽ]').hasMatch(value)) {
                            return 'Ime mora početi velikim slovom.';
                          } else if (!RegExp(r'^[a-zA-ZšđčćžŠĐČĆŽ\s]+$')
                              .hasMatch(value)) {
                            return 'Ime može sadržavati samo slova.';
                          } else if (value.length < 3) {
                            return 'Morate unijeti najmanje 3 karaktera.';
                          } else if (value.length > 50) {
                            return 'Premašili ste maksimalan broj karaktera (50).';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                        name: "prezime",
                        focusNode: _prezimeFocusNode,
                        controller: prezimeController,
                        decoration: const InputDecoration(labelText: "Prezime"),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_telefonFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno!';
                          } else if (!RegExp(r'^[A-Z-ŠĐČĆŽ]').hasMatch(value)) {
                            return 'Prezime mora početi velikim slovom.';
                          } else if (!RegExp(r'^[a-zA-ZšđčćžŠĐČĆŽ\s]+$')
                              .hasMatch(value)) {
                            return 'Prezime može sadržavati samo slova.';
                          } else if (value.length < 3) {
                            return 'Morate unijeti najmanje 3 karaktera.';
                          } else if (value.length > 50) {
                            return 'Premašili ste maksimalan broj karaktera (50).';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                          name: "telefon",
                          focusNode: _telefonFocusNode,
                          controller: telefonController,
                          decoration:
                              const InputDecoration(labelText: "Telefon"),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'Ovo polje može sadržavati samo brojeve.';
                              } else if (value.length < 9) {
                                return 'Broj telefona može imati minimalno 9 cifara.';
                              } else if (value.length > 10) {
                                return 'Broj telefona može imati maksimalno 10 cifara.';
                              }
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                        name: "email",
                        focusNode: _emailFocusNode,
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "E-mail"),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_adresaFocusNode),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Unesite validnu e-mail adresu.';
                            } else if (value.length > 50) {
                              return 'Premašili ste maksimalan broj karaktera (50).';
                            }
                          }
                          return null;
                        },
                      ),
                      FormBuilderTextField(
                        name: "korisnickoIme",
                        focusNode: _usernameFocusNode,
                        controller: korisnickoImeController,
                        decoration: InputDecoration(
                          labelText: "Korisničko ime",
                          errorText: usernameTaken
                              ? "Admin sa ovim korisničkim imenom već postoji."
                              : null,
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_lozinkaFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno!';
                          } else if (value.length < 5) {
                            return 'Morate unijeti najmanje 5 karaktera.';
                          } else if (value.length > 50) {
                            return 'Premašili ste maksimalan broj karaktera (50).';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      FormBuilderTextField(
                        name: "password",
                        focusNode: _lozinkaFocusNode,
                        controller: lozinkaController,
                        decoration: const InputDecoration(labelText: "Lozinka"),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno!';
                          } else if (value.length < 8 ||
                              !value.contains(RegExp(r'[A-Z]')) ||
                              !value.contains(RegExp(r'[a-z]')) ||
                              !value.contains(RegExp(r'[0-9]'))) {
                            return '8 karaktera, uključujući najmanje jedno veliko slovo (A-Z), jedno malo slovo (a-z) i jednu cifru (0-9)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          // Check if the form is valid
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            // Validate if username is available
                            Korisnik noviKorisnik = Korisnik(
                              ime: imeController.text,
                              prezime: prezimeController.text,
                              telefon: telefonController.text,
                              email: emailController.text,
                              korisnickoIme: korisnickoImeController.text,
                              password: lozinkaController.text,
                            );
                            
                            // Save the user to the database via the provider
                            try {
                              await _korisniciProvider.insert(noviKorisnik);
                              
                              // Show success message and navigate to login page
                              _showAlertDialog('Uspješno ste registrirani', 'Možete se prijaviti sada.', Colors.green);
                              Navigator.pushReplacementNamed(context, '/login');
                            } catch (e) {
                              // Handle error while saving the user
                              _showSnackbar('Greška pri registraciji: $e');
                            }
                          } else {
                            _showSnackbar('Molimo vas ispunite sva polja.');
                          }
                        },
                        child: Text(
                          "Spremaj",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 63, 125, 137),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(String naslov, String poruka, Color boja) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 238, 247, 255),
        title: Text(
          naslov,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: boja,
          ),
        ),
        content: Text(
          poruka,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            child: const Text("OK"),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
