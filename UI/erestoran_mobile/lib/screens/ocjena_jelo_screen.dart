import 'package:erestoran_mobile/models/dojmovi.dart';
import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/providers/dojmovi_provider.dart';
import 'package:erestoran_mobile/providers/jelo_provider.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:erestoran_mobile/screens/preporuceni_screen.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OcjenaJeloScreen extends StatefulWidget {
  final Dojmovi? dojmovi;
  OcjenaJeloScreen({Key? key, this.dojmovi}) : super(key: key);

  @override
  State<OcjenaJeloScreen> createState() =>
      _OcjenaJeloScreen();
}

class _OcjenaJeloScreen extends State<OcjenaJeloScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late DojmoviProvider _dojmoviProvider;
  late ProductProvider _productProvider;

  List<Korisnik>? _korisnik;
  List<Jelo>? _jelo;
  List<Dojmovi>? _dojmoviJelo;

  String? _selectedKorisnikId;
  String? _selectedJeloId;

  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ocjena': widget.dojmovi?.ocjena,
      'opis': widget.dojmovi?.opis,
      'korisnikId': widget.dojmovi?.korisnikId,
      'jeloId': widget.dojmovi?.jeloId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dojmoviProvider = context.read<DojmoviProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _productProvider = context.read<ProductProvider>();

    var currentUser = _korisnikProvider.currentUser;
    print(currentUser);

    if (currentUser != null) {
      _initialValue['korisnikId'] = currentUser.id.toString();
    }

    _fetchOcjene();
    _fetchKorisnici();
    _fetchJelo();
  }

  Future<void> _fetchOcjene() async {
    try {
      var ocjeneJelaData = await _dojmoviProvider.get();
      setState(() {
        _dojmoviJelo = ocjeneJelaData.result;
      });
    } catch (e) {
      print('Error fetching ocjene: $e');
    }
  }

  Future<void> _fetchKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnik = korisnikData.result;
      });
    } catch (e) {
      print('Error fetching korisnici: $e');
    }
  }

  Future<void> _fetchJelo() async {
    try {
      var jeloData = await _productProvider.get();
      setState(() {
        _jelo = jeloData.result;
      });
    } catch (e) {
      print('Error fetching jelo: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['ocjena'] != null) {
        mutableFormData['ocjena'] = mutableFormData['ocjena'] is int
            ? mutableFormData['ocjena']
            : int.tryParse(mutableFormData['ocjena'].toString()) ?? 0;
      }

      mutableFormData['korisnikId'] = _korisnikProvider.currentUser?.id;


      if (mutableFormData['jeloId'] != null) {
        mutableFormData['jeloId'] = mutableFormData['jeloId'] is int
            ? mutableFormData['jeloId']
            : int.tryParse(mutableFormData['jeloId'].toString()) ?? 0;
      }

      try {
        String successMessage;

        if (widget.dojmovi == null) {
          await _dojmoviProvider
              .insert(Dojmovi.fromJson(mutableFormData));
          successMessage = 'Ocjena uspješno dodana.';
        } else {
          if (widget.dojmovi!.ocjena == null) {
            throw Exception('Ocjena ID is null');
          }
          await _dojmoviProvider.update(
            widget.dojmovi!.ocjena!,
            Dojmovi.fromJson(mutableFormData),
          );
          successMessage = 'Ocjena uspješno uređena.';
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecommendedJeloScreen(),
                    ),
                  );
                },
                child: Text('Recommended jelo'),
              ),
            ],
          ),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save the evaluation. Please try again.'),
          ),
        );
      }
    } else {
      final validationErrors = _formKey.currentState?.errors;
      print('Validation errors: $validationErrors');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Form validation failed. Please correct the errors and try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add jelo ocjena',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Text(
                  '${_korisnikProvider.currentUser?.ime ?? 'Nepoznat korisnik'}, welcome to the section for adding Your rate for jelo.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 8.0,
                ),
                
                Offstage(
                  offstage: true,
                  child: FormBuilderTextField(
                    name: 'korisnikId',
                    initialValue:
                        _korisnikProvider.currentUser?.id.toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Korisnik (ID)',
                      border: OutlineInputBorder(),
                      hintText: "Nepoznat korisnik",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderDropdown<int>(
                  name: 'ocjena',
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(5, (index) {
                    int rating = index + 1;
                    return DropdownMenuItem<int>(
                      value: rating,
                      child: Text(rating.toString()),
                    );
                  }),
                  initialValue: _initialValue['ocjena'],
                  onChanged: (value) {
                    setState(() {
                      _selectedJeloId = value?.toString();
                    });
                    print("Odabrana ocjena: $value");
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Reason",
                    border: OutlineInputBorder(),
                  ),
                  name: "opis",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'jeloId',
                  decoration: InputDecoration(
                    labelText: 'Jelo',
                  ),
                  items: _jelo
                          ?.map((jelo) => DropdownMenuItem<String>(
                                value: jelo.jeloId.toString(),
                                child: Text(jelo.naziv ?? ""),
                              ))
                          .toList() ??
                      [],
                  initialValue: _initialValue['jeloId']?.toString(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJeloId = value;
                    });
                    print("Odabrani jeloId: $_selectedJeloId");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}