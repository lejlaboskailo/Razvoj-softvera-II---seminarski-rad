
import 'package:erestoran_admin/models/stavkeNarudzbe.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class stavkeNarudzbeProvider extends BaseProvider<StavkeNarudzbe> {
  stavkeNarudzbeProvider(): super("stavkeNarudzbe");

   @override
  StavkeNarudzbe fromJson(data) {
    return StavkeNarudzbe.fromJson(data);
  }
}