

import 'package:erestoran_mobile/models/uloga.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';

class UlogaProvider extends BaseProvider<Uloga> {
  UlogaProvider(): super("Uloga");

   @override
  Uloga fromJson(data) {
    return Uloga.fromJson(data);
  }
}