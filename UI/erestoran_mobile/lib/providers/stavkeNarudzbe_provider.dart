

import 'package:erestoran_mobile/models/stavkeNarudzbe.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';

class StavkeNarudzbeProvider extends BaseProvider<StavkeNarudzbe> {
  StavkeNarudzbeProvider(): super("stavkeNarudzbe");

   @override
  StavkeNarudzbe fromJson(data) {
    return StavkeNarudzbe.fromJson(data);
  }
}