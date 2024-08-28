
import 'package:erestoran_admin/models/korisnik.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider(): super("Korisnik");

   @override
  Korisnik fromJson(data) {
    // TODO: implement fromJson
    return Korisnik.fromJson(data);
  }
  
}

