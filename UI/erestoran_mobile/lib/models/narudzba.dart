

import 'dart:convert';
 
import 'package:erestoran_mobile/models/jelo.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'narudzba.g.dart';
 
@JsonSerializable()
class Narudzba{
int? narudzbaId;
DateTime? datumNarudzbe;
int? korisnikId;
int? StatusNarudzbeId;
 
 
Narudzba(this.narudzbaId, this.datumNarudzbe, this.korisnikId, this.StatusNarudzbeId);
 
factory Narudzba.fromJson(Map<String,dynamic> json)=>_$NarudzbaFromJson(json);
 
Map<String,dynamic> toJson()=>_$NarudzbaToJson(this);
}
 