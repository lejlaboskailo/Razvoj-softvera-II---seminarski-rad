// ignore_for_file: prefer_const_constructors

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

class KategorijaDetailScreen extends StatefulWidget {
  Kategorija? kategorija;
  KategorijaDetailScreen({Key? key, this.kategorija}) : super(key: key);

  @override
  State<KategorijaDetailScreen> createState() => _KategorijaDetailScreen();
}

class _KategorijaDetailScreen extends State<KategorijaDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KategorijaProvider _kategorijaProvider;

  SearchResult<Kategorija>? kategorijaResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'id': widget.kategorija?.id,
      'naziv': widget.kategorija?.naziv,
      'opis': widget.kategorija?.opis,
    };

    _kategorijaProvider = context.read<KategorijaProvider>();

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

                    try {
                      if (widget.kategorija == null) {
                        await _kategorijaProvider.insert(request);
                      } else {
                        await _kategorijaProvider.update(widget.kategorija!.id!, request);
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
                 child: Text(widget.kategorija == null ? "Sačuvaj" : "Uredi")
                ),
              )
            ],
          )
        ],
      ),
      title: this.widget.kategorija?.naziv ?? "Kategorija detalji",
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
