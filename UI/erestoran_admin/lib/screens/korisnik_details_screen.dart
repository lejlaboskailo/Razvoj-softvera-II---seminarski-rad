import 'package:erestoran_admin/providers/korisnik_provider.dart';
import 'package:erestoran_admin/screens/korisnik_profile_screen.dart';
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
          // If it's a new user, insert it.
          await _korisnikProvider.insert(Korisnik.fromJson(formData));
          _showSuccessDialog('User added successfully');
        } else {
          // Update the existing user.
          await _korisnikProvider.update(
              widget.korisnik!.id!, Korisnik.fromJson(formData));
          _showSuccessDialog('User updated successfully');

          // After updating, go back to the previous screen (KorisnikScreen).
          Navigator.of(context)
              .pop(); // This pops the details screen and goes back to the previous screen.
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

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        KorisnikScreen(), // This ensures the screen reloads after the update.
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
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
                      ? 'Edit User Details'
                      : 'Add New User',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildFormField("First name", "ime", Icons.person),
                SizedBox(height: 16),
                _buildFormField("Last name", "prezime", Icons.person_outline),
                SizedBox(height: 16),
                _buildFormField(
                    "Username", "korisnickoIme", Icons.account_circle),
                SizedBox(height: 16),
                _buildFormField("Telefon", "telefon", Icons.phone),
                SizedBox(height: 16),
                _buildFormField("Email", "email", Icons.email),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color.fromARGB(255, 63, 125, 137),
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
                    widget.korisnik == null ? 'Add User' : 'Update User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.korisnik != null
          ? "User: ${widget.korisnik?.ime}"
          : "User Details",
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
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 63, 125, 137)),
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
        labelText: "Date of Birth",
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
        labelText: "Gender",
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
