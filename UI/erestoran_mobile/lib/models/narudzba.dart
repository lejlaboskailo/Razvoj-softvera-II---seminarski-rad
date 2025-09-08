

import 'dart:convert';
 
import 'package:erestoran_mobile/models/jelo.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'narudzba.g.dart';
 
@JsonSerializable()
class Narudzba{
@JsonKey(name: 'id')
int? narudzbaId;
DateTime? datumNarudzbe;
int? korisnikId;
String? stateMachine;
int? StatusNarudzbeId;
 
 
Narudzba(this.narudzbaId, this.datumNarudzbe, this.korisnikId, this.StatusNarudzbeId, this.stateMachine);
 
factory Narudzba.fromJson(Map<String,dynamic> json)=>_$NarudzbaFromJson(json);
 
Map<String,dynamic> toJson()=>_$NarudzbaToJson(this);
}
 