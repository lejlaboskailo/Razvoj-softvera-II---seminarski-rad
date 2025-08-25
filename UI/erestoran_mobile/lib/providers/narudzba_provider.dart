import 'package:erestoran_mobile/models/korpa.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';
import 'package:flutter/material.dart';
import '../models/jelo.dart';
import 'package:http/http.dart' as http;

class NarudzbaProvider extends BaseProvider<dynamic> {
  NarudzbaProvider() : super("Narudzba");

  @override
  fromJson(data) => data; // ili model ako imaš

  /*Future<int> checkoutFromCart(int korisnikId, String? paymentId) async {
    final uri = Uri.parse('$totalUrl/checkoutFromCart');
    final res = await http.post(uri, headers: createHeaders());
    if (isValidResponse(res)) {
      return int.parse(res.body);
    }
    throw Exception('Checkout nije uspio: ${res.statusCode} ${res.body}');
  }*/
}

