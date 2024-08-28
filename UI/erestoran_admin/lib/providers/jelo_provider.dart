 
import 'package:erestoran_admin/models/jelo.dart';
import 'package:erestoran_admin/providers/base_provider.dart';
 
class ProductProvider extends BaseProvider<Jelo> {
  ProductProvider(): super("Jelo");
 
   @override
  Jelo fromJson(data) {
    // TODO: implement fromJson
    return Jelo.fromJson(data);
  }
}