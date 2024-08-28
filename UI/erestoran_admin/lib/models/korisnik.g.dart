// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      json['Id'] as int?,
      json['Ime'] as String?,
      json['Prezime'] as String?,
      json['KorisnickoIme'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'Id': instance.Id,
      'Ime': instance.Ime,
      'Prezime': instance.Prezime,
      'KorisnickoIme': instance.KorisnickoIme,
    };
