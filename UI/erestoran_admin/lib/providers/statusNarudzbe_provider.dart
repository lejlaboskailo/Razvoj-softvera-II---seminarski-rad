
import 'package:erestoran_admin/models/statusNarudzbe.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class StatusNarudzbeProvider extends BaseProvider<StatusNarudzbe> {
  StatusNarudzbeProvider(): super("StatusNarudzbe");

   @override
  StatusNarudzbe fromJson(data) {
    return StatusNarudzbe.fromJson(data);
  }
}