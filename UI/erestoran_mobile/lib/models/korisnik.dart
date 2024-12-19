import 'package:erestoran_mobile/models/korisnik_uloga.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik{
int? id;
String? ime;
String? prezime;
String? korisnickoIme;
List<KorisnikUloga> korisniciUloges;

Korisnik({this.id,this.ime,this.prezime,this.korisnickoIme, this.korisniciUloges = const []});

factory Korisnik.fromJson(Map<String,dynamic> json)=>_$KorisnikFromJson(json);

Map<String,dynamic> toJson()=>_$KorisnikToJson(this);
}
