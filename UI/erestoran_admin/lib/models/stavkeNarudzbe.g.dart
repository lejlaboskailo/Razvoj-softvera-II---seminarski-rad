// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stavkeNarudzbe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StavkeNarudzbe _$StavkeNarudzbeFromJson(Map<String, dynamic> json) =>
    StavkeNarudzbe(
      json['id'] as int?,
      json['kolicina'] as int?,
      json['cijena'] as int?,
      json['jeloId'] as int?,
      json['narudzbaId'] as int?,
      json['ukupno'] as int?,
    );

Map<String, dynamic> _$StavkeNarudzbeToJson(StavkeNarudzbe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kolicina': instance.kolicina,
      'cijena': instance.cijena,
      'jeloId': instance.jeloId,
      'narudzbaId': instance.narudzbaId,
      'ukupno': instance.ukupno,
    };
