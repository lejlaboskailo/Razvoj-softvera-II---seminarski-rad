// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      (json['narudzbaId'] as num?)?.toInt(),
      json['datumNarudzbe'] == null
          ? null
          : DateTime.parse(json['datumNarudzbe'] as String),
      (json['korisnikId'] as num?)?.toInt(),
      (json['StatusNarudzbeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'narudzbaId': instance.narudzbaId,
      'datumNarudzbe': instance.datumNarudzbe?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'StatusNarudzbeId': instance.StatusNarudzbeId,
    };
