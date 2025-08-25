
import 'package:erestoran_admin/models/kategorija.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija> {
  KategorijaProvider(): super("Kategorija");

   @override
  Kategorija fromJson(data) {
    return Kategorija.fromJson(data);
  }
}