// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uplata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uplata _$UplataFromJson(Map<String, dynamic> json) => Uplata(
      json['Id'] as int?,
      json['Iznos'] as int?,
      json['BrojTransakcije'] as String?,
      json['DatumTransakcije'] as String?,
      json['KorisnikId'] as int?,
    );

Map<String, dynamic> _$UplataToJson(Uplata instance) => <String, dynamic>{
      'Id': instance.Id,
      'Iznos': instance.Iznos,
      'BrojTransakcije': instance.BrojTransakcije,
      'DatumTransakcije': instance.DatumTransakcije,
      'KorisnikId': instance.KorisnikId,
    };
