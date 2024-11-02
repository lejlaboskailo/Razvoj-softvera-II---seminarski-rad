// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dojmovi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dojmovi _$DojmoviFromJson(Map<String, dynamic> json) => Dojmovi(
      json['id'] as int?,
      json['ocjena'] as int?,
      json['opis'] as String?,
      json['jeloId'] as int?,
      json['korisnikId'] as int?,
    );

Map<String, dynamic> _$DojmoviToJson(Dojmovi instance) => <String, dynamic>{
      'id': instance.id,
      'ocjena': instance.ocjena,
      'opis': instance.opis,
      'jeloId': instance.jeloId,
      'korisnikId': instance.korisnikId,
    };
