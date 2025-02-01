 
import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/models/restoran.dart';
import 'package:erestoran_admin/providers/base_provider.dart';
 
class RestoranProvider extends BaseProvider<Restoran> {
  RestoranProvider(): super("Restoran");
 
   @override
  Restoran fromJson(data) {
    return Restoran.fromJson(data);
  }
}