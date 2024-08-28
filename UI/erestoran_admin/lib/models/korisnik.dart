import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik{
int? Id;
String? Ime;
String? Prezime;
String? KorisnickoIme;

Korisnik(this.Id,this.Ime,this.Prezime,this.KorisnickoIme);

factory Korisnik.fromJson(Map<String,dynamic> json)=>_$KorisnikFromJson(json);

Map<String,dynamic> toJson()=>_$KorisnikToJson(this);
}
