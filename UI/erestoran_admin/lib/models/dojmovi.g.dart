// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dojmovi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dojmovi _$DojmoviFromJson(Map<String, dynamic> json) => Dojmovi(
      json['Id'] as int?,
      json['Ocjena'] as int?,
      json['Opis'] as String?,
      json['JeloId'] as int?,
      json['KorisnikId'] as int?,
    );

Map<String, dynamic> _$DojmoviToJson(Dojmovi instance) => <String, dynamic>{
      'Id': instance.Id,
      'Ocjena': instance.Ocjena,
      'Opis': instance.Opis,
      'JeloId': instance.JeloId,
      'KorisnikId': instance.KorisnikId,
    };
