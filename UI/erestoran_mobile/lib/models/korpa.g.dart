// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korpa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korpa _$KorpaFromJson(Map<String, dynamic> json) => Korpa(
      (json['korpaId'] as num?)?.toInt(),
      (json['proizvodId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      (json['cijena'] as num?)?.toDouble(),
      (json['kolicina'] as num?)?.toInt(),
      (json['kategorijaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KorpaToJson(Korpa instance) => <String, dynamic>{
      'korpaId': instance.korpaId,
      'proizvodId': instance.proizvodId,
      'korisnikId': instance.korisnikId,
      'cijena': instance.cijena,
      'kolicina': instance.kolicina,
      'kategorijaId': instance.kategorijaId,
    };
