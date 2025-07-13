/*import 'dart:convert';
import 'dart:io';
import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetailScreen extends StatefulWidget {
  final Jelo? jelo;
  final Function()? onProductUpdated; 

  ProductDetailScreen({Key? key, this.jelo, this.onProductUpdated})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KategorijaProvider _kategorijaProvider;
  late ProductProvider _productProvider;

  SearchResult<Kategorija>? kategorijaResult;
  bool isLoading = true;
  String? _base64Image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _productProvider = context.read<ProductProvider>();
    initForm();
  }

  Future<void> initForm() async {
    kategorijaResult = await _kategorijaProvider.get();

    if (kategorijaResult == null || kategorijaResult!.result == null) {
      print('Kategorija result je null ili prazan');
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
          isLoading ? CircularProgressIndicator() : _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      var request = Map.from(_formKey.currentState!.value);
                      request['slika'] = _base64Image; 

                      try {
                        if (widget.jelo == null) {
                          await _productProvider.insert(request);
                          _showSnackbar("Jelo je uspješno dodano.");
                        } else {
                          await _productProvider.update(
                              widget.jelo!.id!, request);
                          _showSnackbar("Jelo je uspješno uređeno.");
                        }

                        if (widget.onProductUpdated != null) {
                          widget.onProductUpdated!();
                        }

                        Navigator.of(context)
                            .pop(); 
                      } catch (e) {
                        print('Error occurred: $e');
                        _showErrorDialog(e.toString());
                      }
                    }
                  },
                  child: Text(widget.jelo == null ? "Sačuvaj" : "Uredi"),
                ),
              )
            ],
          ),
        ],
      ),
      title: widget.jelo?.naziv ?? "Detalji proizvoda",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: {
        'sifra': widget.jelo?.id,
        'naziv': widget.jelo?.naziv,
        'cijena': widget.jelo?.cijena?.toString(),
        'opis': widget.jelo?.opis,
        'kategorijaId': widget.jelo?.kategorijaId?.toString(),
        'slika': widget.jelo?.slika,
      },
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Naziv"),
                name: "naziv",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Opis"),
                name: "opis",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderDropdown<String>(
                name: 'kategorijaId',
                decoration: InputDecoration(labelText: 'Kategorija'),
                items: kategorijaResult?.result
                        .map((item) => DropdownMenuItem<String>(value: item.id.toString(), child: Text(item.naziv ?? "")))
                        .toList() ?? [],
                initialValue: widget.jelo?.kategorijaId?.toString(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(labelText: "Cijena"),
                name: "cijena",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderField(
                name: 'imageId',
                builder: (field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      label: Text(_base64Image != null ? '' : 'Odaberite sliku'),
                      errorText: field.errorText,
                    ),
                    child: _base64Image != null
                        ? Container(
                            constraints: BoxConstraints(
                              maxHeight: 200,
                              maxWidth: double.infinity,
                            ),
                            child: Image.memory(
                              base64Decode(_base64Image!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : ListTile(
                            leading: Icon(Icons.photo),
                            title: Text("Odaberite sliku"),
                            trailing: Icon(Icons.file_upload),
                            onTap: _pickImage,
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ]), 
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
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
        title: Text("Greška"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
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
}
*/
import 'dart:convert';
import 'dart:io';
import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetailScreen extends StatefulWidget {
  final Jelo? jelo;
  final Function()? onProductUpdated;

  ProductDetailScreen({Key? key, this.jelo, this.onProductUpdated})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KategorijaProvider _kategorijaProvider;
  late ProductProvider _productProvider;

  SearchResult<Kategorija>? kategorijaResult;
  bool isLoading = true;
  String? _base64Image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _productProvider = context.read<ProductProvider>();
    initForm();
  }

  Future<void> initForm() async {
    kategorijaResult = await _kategorijaProvider.get();

    if (kategorijaResult == null || kategorijaResult!.result == null) {
      print('Kategorija result je null ili prazan');
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
                        if (widget.jelo == null) {
                          await _productProvider.insert(request);
                          _showSnackbar("Jelo je uspješno dodano.");
                        } else {
                          await _productProvider.update(widget.jelo!.jeloId!, request);
                          _showSnackbar("Jelo je uspješno uređeno.");
                        }

                        if (widget.onProductUpdated != null) {
                          widget.onProductUpdated!();
                        }

                        Navigator.of(context).pop();
                      } catch (e) {
                        print('Error occurred: $e');
                        _showErrorDialog(e.toString());
                      }
                    }
                  },
                  child: Text(widget.jelo == null ? "Sačuvaj" : "Uredi"),
                ),
              ),
            ],
          ),
        ],
      ),
      title: widget.jelo?.naziv ?? "Detalji proizvoda",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: {
        'sifra': widget.jelo?.jeloId,
        'naziv': widget.jelo?.naziv,
        'cijena': widget.jelo?.cijena?.toString(),
        'opis': widget.jelo?.opis,
        'kategorijaId': widget.jelo?.kategorijaId?.toString(),
        'slika': widget.jelo?.slika,
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "naziv",
                    decoration: InputDecoration(
                      labelText: "Naziv",
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
                    name: "opis",
                    decoration: InputDecoration(
                      labelText: "Opis",
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
                  child: FormBuilderDropdown<String>(
                    name: 'kategorijaId',
                    decoration: InputDecoration(
                      labelText: 'Kategorija',
                      labelStyle: TextStyle(color: Colors.orangeAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    items: kategorijaResult?.result
                            .map((item) => DropdownMenuItem<String>(
                                value: item.kategorijaId.toString(),
                                child: Text(item.naziv ?? "")))
                            .toList() ??
                        [],
                    initialValue: widget.jelo?.kategorijaId?.toString(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FormBuilderTextField(
                    name: "cijena",
                    decoration: InputDecoration(
                      labelText: "Cijena",
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
                  child: FormBuilderField(
                    name: 'imageId',
                    builder: (field) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          label: Text(
                              _base64Image != null ? '' : 'Odaberite sliku'),
                          errorText: field.errorText,
                          labelStyle: TextStyle(color: Colors.orangeAccent),
                        ),
                        child: _base64Image != null
                            ? Container(
                                constraints: BoxConstraints(
                                  maxHeight: 200,
                                  maxWidth: double.infinity,
                                ),
                                child: Image.memory(
                                  base64Decode(_base64Image!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ListTile(
                                leading: Icon(
                                  Icons.photo,
                                  color: Colors.orangeAccent,
                                ),
                                title: Text("Odaberite sliku"),
                                trailing: Icon(
                                  Icons.file_upload,
                                  color: Colors.orangeAccent,
                                ),
                                onTap: _pickImage,
                              ),
                      );
                    },
                  ),
                ),
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
