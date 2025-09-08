// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      (json['id'] as num?)?.toInt(),
      json['datumNarudzbe'] == null
          ? null
          : DateTime.parse(json['datumNarudzbe'] as String),
      (json['korisnikId'] as num?)?.toInt(),
      (json['StatusNarudzbeId'] as num?)?.toInt(),
      json['stateMachine'] as String?,
    );

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'id': instance.narudzbaId,
      'datumNarudzbe': instance.datumNarudzbe?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'stateMachine': instance.stateMachine,
      'StatusNarudzbeId': instance.StatusNarudzbeId,
    };
