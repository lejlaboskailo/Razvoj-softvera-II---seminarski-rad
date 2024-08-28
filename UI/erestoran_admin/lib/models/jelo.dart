import 'package:json_annotation/json_annotation.dart';

part 'jelo.g.dart';

@JsonSerializable()
class Jelo {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'naziv')
  String? naziv;

  @JsonKey(name: 'opis')
  String? opis;

  @JsonKey(name: 'cijena')
  double? cijena;

  @JsonKey(name: 'kategorijaId')
  int? kategorijaId;

  @JsonKey(name: 'slika')
  String? slika;

  Jelo(this.id, this.naziv, this.opis, this.cijena, this.kategorijaId, this.slika);

  factory Jelo.fromJson(Map<String, dynamic> json) => _$JeloFromJson(json);

  Map<String, dynamic> toJson() => _$JeloToJson(this);
}
