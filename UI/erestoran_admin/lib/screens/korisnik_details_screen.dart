import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:erestoran_admin/models/korisnik.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KorisniciDetailsScreen extends StatefulWidget {
  final Korisnik? korisnik;
  KorisniciDetailsScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<KorisniciDetailsScreen> createState() => _KorisniciDetailsScreenState();
}

class _KorisniciDetailsScreenState extends State<KorisniciDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ime': widget.korisnik?.ime,
      'prezime': widget.korisnik?.prezime,
      'korisnickoIme': widget.korisnik?.korisnickoIme,
      'telefon': widget.korisnik?.telefon,
      'email': widget.korisnik?.email,
      'korisnikUlogas': widget.korisnik?.korisniciUloges ?? [],
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formData = Map.from(_formKey.currentState!.value);

      try {
        if (formData['datumRodjenja'] != null &&
            formData['datumRodjenja'] is DateTime) {
          formData['datumRodjenja'] =
              DateFormat('yyyy-MM-dd').format(formData['datumRodjenja']);
        }

        if (widget.korisnik == null) {
          await _korisnikProvider.insert(Korisnik.fromJson(formData));
          _showSuccessDialog('Korisnik uspjesno dodan.');
        } else {
          await _korisnikProvider.update(
              widget.korisnik!.id!, Korisnik.fromJson(formData));
          _showSuccessDialog('Podaci korisnika uspjesno uredjeni.');

          if (!mounted) return;
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Error"),
            content:
                Text("Failed to save user. Please try again: ${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showSuccessDialog(String message, {bool popParent = false}) {
    final rootContext = context; 

    showDialog(
      context: rootContext,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Uspjesno'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop(); 
              if (popParent) {
                Navigator.of(rootContext)
                    .pop(true); 
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
                  widget.korisnik != null
                      ? 'Uredi profil korisnika'
                      : 'Dodaj novi korisnik',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildFormField("Ime korisnika", "ime", Icons.person),
                SizedBox(height: 16),
                _buildFormField(
                    "Prezime korisnika", "prezime", Icons.person_outline),
                SizedBox(height: 16),
                _buildFormField(
                    "Korisnicko ime", "korisnickoIme", Icons.account_circle),
                SizedBox(height: 16),
                _buildFormField("Telefon", "telefon", Icons.phone),
                SizedBox(height: 16),
                _buildFormField("Email", "email", Icons.email),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color.fromARGB(255, 146, 89, 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    widget.korisnik == null ? 'Dodaj' : 'Spasi',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.korisnik != null
          ? "Korisnik: ${widget.korisnik?.ime}"
          : "Detalji korisnika",
    );
  }

  Widget _buildFormField(String label, String name, IconData icon,
      {bool obscureText = false}) {
    return FormBuilderTextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(icon, color: Colors.orange),
      ),
      name: name,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return FormBuilderDateTimePicker(
      name: "datumRodjenja",
      inputType: InputType.date,
      format: DateFormat('yyyy-MM-dd'),
      decoration: InputDecoration(
        labelText: "Datum rodjenja",
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.calendar_today,
            color: const Color.fromARGB(255, 63, 125, 137)),
      ),
      validator: (value) {
        if (value == null) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return FormBuilderDropdown(
      name: 'spol',
      decoration: InputDecoration(
        labelText: "Spol",
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(Icons.person_add_alt_1,
            color: const Color.fromARGB(255, 63, 125, 137)),
      ),
      items: [
        DropdownMenuItem(value: 'M', child: Text('Muški')),
        DropdownMenuItem(value: 'Ž', child: Text('Ženski')),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
