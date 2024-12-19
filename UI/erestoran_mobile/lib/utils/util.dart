import 'dart:convert';
 
import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/models/uloga.dart';
import 'package:flutter/cupertino.dart';
 
class Authorization {
  static String? username;
  static String? password;
  static int? userId;
  static Korisnik? korisnik;
  static Uloga? uloga;

}
Image imageFromBase64String(String base64Image){
  return Image.memory(base64Decode(base64Image));
}