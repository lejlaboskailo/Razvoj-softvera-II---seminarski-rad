

import 'package:erestoran_mobile/models/korisnik_uloga.dart';
import 'package:erestoran_mobile/models/uloga.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';

class KorisnikUlogaProvider extends BaseProvider<KorisnikUloga> {
  KorisnikUlogaProvider(): super("KorisniciUloga");

   @override
  KorisnikUloga fromJson(data) {
    return KorisnikUloga.fromJson(data);
  }
}