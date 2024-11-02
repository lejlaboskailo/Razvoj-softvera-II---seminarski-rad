// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jelo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jelo _$JeloFromJson(Map<String, dynamic> json) => Jelo(
      json['id'] as int?,
      json['naziv'] as String?,
      json['slika'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      json['opis'] as String?,
      json['kategorijaId'] as int?
    );

Map<String, dynamic> _$JeloToJson(Jelo instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'kategorijaId': instance.kategorijaId,
      'slika': instance.slika,
    };
