 
 
import 'dart:convert';

import 'package:erestoran_mobile/models/jelo.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MeniProvider extends BaseProvider<Jelo> {
  MeniProvider(): super("Jelo");
 
   @override
  Jelo fromJson(data) {
    return Jelo.fromJson(data);
  }
 final String apiUrl = 'http://localhost:7002/Jelo';
  Future<List<Jelo>> getPreporucenaJela(int korisnikId) async {
    final response = await http.get(Uri.parse('$apiUrl/preporuceno/$korisnikId'));

    if (response.statusCode == 200) {
      // Ako je odgovor uspešan, pretvori JSON u Listu Jelo objekata
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Jelo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load recommended dishes');
    }
  }


  
}