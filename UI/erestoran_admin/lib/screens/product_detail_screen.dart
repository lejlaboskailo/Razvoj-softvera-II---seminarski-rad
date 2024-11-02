// ignore_for_file: prefer_const_constructors
/*
import 'dart:convert';
import 'dart:io';

import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class ProductDetailScreen extends StatefulWidget {
  Jelo? jelo;
  ProductDetailScreen({Key? key, this.jelo}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KategorijaProvider _kategorijaProvider;
  late ProductProvider _productProvider;

  SearchResult<Kategorija>? kategorijaResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'sifra': widget.jelo?.id,
      'naziv': widget.jelo?.naziv,
      'cijena': widget.jelo?.cijena?.toString(),
      'opis': widget.jelo?.opis,
      'kategorijaId': widget.jelo?.kategorijaId?.toString(),
      'slika': widget.jelo?.slika, // Dodaj sliku u inicijalne vrijednosti
    };

    _kategorijaProvider = context.read<KategorijaProvider>();
    _productProvider = context.read<ProductProvider>();

    initForm();
  }

  Future initForm() async {
    kategorijaResult = await _kategorijaProvider.get();
  
    // Provjeri podatke
    if (kategorijaResult == null || kategorijaResult!.result == null) {
      print('Kategorija result je null ili prazan');
      return;
    }

    // Ispisivanje itema
    for (var item in kategorijaResult!.result) {
      print('Dropdown item: ${item.id} - ${item.naziv}');
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
          isLoading ? Container() : _buildForm(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.saveAndValidate();

                    print(_formKey.currentState?.value);
                    print(_formKey.currentState?.value['naziv']);

                    var request = new Map.from(_formKey.currentState!.value);

                    request['slika'] = _base64Image;

                    print(request['slika']);
                    
                    try {
                      if (widget.jelo == null) {
                        await _productProvider.insert(request);
                      } else {
                        await _productProvider.update(widget.jelo!.id!, request);
                      }
                    } on Exception catch (e) {
                      print('Error occurred: $e'); // Ovdje ispiši grešku za lakše debagiranje
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK")
                            )
                          ],
                        )
                      );
                    }
                  },
                 child: Text(widget.jelo == null ? "Sačuvaj" : "Uredi")
                ),
              )
            ],
          )
        ],
      ),
      title: this.widget.jelo?.naziv ?? "Product details",
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
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
                decoration: InputDecoration(
                  labelText: 'Kategorija',
                ),
                items: kategorijaResult?.result
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(
                            item.naziv ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList() ?? [],
                initialValue: _initialValue['kategorijaId'] ?? null,
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
              label: _initialValue['slika'] != null
                  ? Text('') 
                  : Text('Odaberite sliku'), // Label za dodavanje slike
              errorText: field.errorText,
            ),
            child: _initialValue['slika'] != null
                ? Container(
                    constraints: BoxConstraints(
                      maxHeight: 200, // Ovdje postavi željenu maksimalnu visinu
                      maxWidth: double.infinity,
                    ),
                    child: Image.network(
                      _initialValue['slika'],
                      fit: BoxFit.cover,
                    ),
                  )
                : ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("Select image"),
                    trailing: Icon(Icons.file_upload),
                    onTap: getImage,
                    
                  ),
          );
        },
      ),
    ),
  ],
)


      ]),
    );
  }

  File? _image;
  String? _base64Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
      setState(() {
        _initialValue['slika'] = _base64Image; // Update the image in the form's initial value
      });
    }
  }
}
*/

// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/jelo_provider.dart';
import 'package:erestoran_admin/providers/kategorija_provider.dart';
import 'package:erestoran_admin/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';

class ProductDetailScreen extends StatefulWidget {
  final Jelo? jelo;
  ProductDetailScreen({Key? key, this.jelo}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _kategorijaProvider = context.read<KategorijaProvider>();
    _productProvider = context.read<ProductProvider>();
    initForm();
  }

  Future<void> initForm() async {
    kategorijaResult = await _kategorijaProvider.get();
    
    // Provjeri podatke
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
                        } else {
                          await _productProvider.update(widget.jelo!.id!, request);
                        }
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
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(item.naziv ?? ""),
                        ))
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
                            onTap: getImage,
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

  Future<void> getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      var image = File(result.files.single.path!);
      _base64Image = base64Encode(image.readAsBytesSync());
      setState(() {});
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
}
