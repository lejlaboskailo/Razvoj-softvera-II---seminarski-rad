 
import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/narudzba.dart';
import 'package:erestoran_admin/providers/base_provider.dart';
 
class NarudzbaProvider extends BaseProvider<Narudzba> {
  NarudzbaProvider(): super("Narudzba");
 
   @override
  Narudzba fromJson(data) {
    return Narudzba.fromJson(data);
  }
}