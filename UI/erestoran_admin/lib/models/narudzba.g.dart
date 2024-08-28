// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      json['id'] as int?,
      json['datumNarudzbe'] as String?,
      json['korisnikId'] as int?,
      json['statusNarudzbeId'] as int?,
      json['stateMachine'] as String?,
    );

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'id': instance.id,
      'datumNarudzbe': instance.datumNarudzbe,
      'korisnikId': instance.korisnikId,
      'statusNarudzbeId': instance.statusNarudzbeId,
      'stateMachine': instance.stateMachine,
    };
