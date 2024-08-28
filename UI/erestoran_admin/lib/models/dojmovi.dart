import 'package:json_annotation/json_annotation.dart';
 
part 'dojmovi.g.dart';
 
@JsonSerializable()
class Dojmovi{
int? Id;
int? Ocjena;
String? Opis;
int? JeloId;
int? KorisnikId;
Dojmovi(this.Id,this.Ocjena, this.Opis, this.JeloId,this.KorisnikId);
 
factory Dojmovi.fromJson(Map<String,dynamic> json)=>_$DojmoviFromJson(json);
 
Map<String,dynamic> toJson()=>_$DojmoviToJson(this);
}