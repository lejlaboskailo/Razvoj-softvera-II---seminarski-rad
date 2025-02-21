

import 'dart:convert';
 
import 'package:json_annotation/json_annotation.dart';
 
part 'korpa.g.dart';
 
@JsonSerializable()
class Korpa{
int? korpaId;
int? proizvodId;
int? korisnikId;
double? cijena;
int? kolicina;
int? kategorijaId;
 
 
Korpa(this.korpaId, this.proizvodId, this.korisnikId, this.cijena, this.kolicina, this.kategorijaId);
 
factory Korpa.fromJson(Map<String,dynamic> json)=>_$KorpaFromJson(json);
 
Map<String,dynamic> toJson()=>_$KorpaToJson(this);
}
 