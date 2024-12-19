
import 'package:erestoran_admin/models/uloga.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider(): super("Uloga");

   @override
  Uloga fromJson(data) {
    return Uloga.fromJson(data);
  }
}