import 'package:json_annotation/json_annotation.dart';

part 'narudzba.g.dart';

@JsonSerializable()
class Narudzba{
int? id;
String? datumNarudzbe;
int? korisnikId;
int? statusNarudzbeId;
String? stateMachine;
Narudzba(this.id,this.datumNarudzbe,this.korisnikId,
this.statusNarudzbeId,this.stateMachine);

factory Narudzba.fromJson(Map<String,dynamic> json)=>_$NarudzbaFromJson(json);

Map<String,dynamic> toJson()=>_$NarudzbaToJson(this);
}