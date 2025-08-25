
import 'package:erestoran_admin/models/drzava.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class DrzavaProvider extends BaseProvider<Drzava> {
  DrzavaProvider(): super("Drzava");

   @override
  Drzava fromJson(data) {
    return Drzava.fromJson(data);
  }
}