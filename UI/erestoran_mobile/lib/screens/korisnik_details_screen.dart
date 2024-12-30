
import 'dart:convert';
import 'dart:io';
import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/providers/korisnik_provider.dart';
import 'package:erestoran_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import 'package:image_picker/image_picker.dart';

class KorisnikDetailsScreen extends StatefulWidget {
  final Korisnik? korisnik;
  final Function()? onKorisnikUpdated;

  KorisnikDetailsScreen({Key? key, this.korisnik, this.onKorisnikUpdated})
      : super(key: key);

  @override
  State<KorisnikDetailsScreen> createState() => _KorisnikDetailsScreenState();
}

class _KorisnikDetailsScreenState extends State<KorisnikDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;

  SearchResult<Korisnik>? korisnikResults;
  bool isLoading = true;
  String? _base64Image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    initForm();
  }

  Future<void> initForm() async {
    korisnikResults = await _korisnikProvider.get();

    if (korisnikResults == null || korisnikResults!.result == null) {
      print('korisnik result je null ili prazan');
      return;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Column(
        children: [
          isLoading
              ? CircularProgressIndicator()
              : _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      var request = Map.from(_formKey.currentState!.value);
                      request['slika'] = _base64Image;

                      try {
                        if (widget.korisnik == null) {
                          await _korisnikProvider.insert(request);
                          _showSnackbar("Korisnik je uspješno dodano.");
                        } else {
                          await _korisnikProvider.update(widget.korisnik!.id!, request);
                          _showSnackbar("Korisnik je uspješno uređeno.");
                        }

                        if (widget.onKorisnikUpdated != null) {
                          widget.onKorisnikUpdated!();
                        }

                        Navigator.of(context).pop();
                      } catch (e) {
                        print('Error occurred: $e');
                        _showErrorDialog(e.toString());
                      }
                    }
                  },
                  child: Text(widget.korisnik == null ? "Sačuvaj" : "Uredi"),
                ),
              ),
            ],
          ),
        ],
      ),
      title: widget.korisnik?.ime ?? "Detalji korisnik",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: {
        'ime': widget.korisnik?.ime,
        'prezime': widget.korisnik?.prezime,
        'korisnickoIme': widget.korisnik?.korisnickoIme,
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "ime",
                    decoration: InputDecoration(
                      labelText: "Ime",
                      labelStyle: TextStyle(color: Colors.orangeAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "prezime",
                    decoration: InputDecoration(
                      labelText: "Prezime",
                      labelStyle: TextStyle(color: Colors.orangeAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "korisnickoIme",
                    decoration: InputDecoration(
                      labelText: "Korisnicko ime",
                      labelStyle: TextStyle(color: Colors.orangeAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Greška", style: TextStyle(color: Colors.orangeAccent)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.orangeAccent)),
          )
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.orangeAccent,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
