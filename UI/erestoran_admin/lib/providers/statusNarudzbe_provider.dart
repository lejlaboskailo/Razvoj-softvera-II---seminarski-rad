
import 'package:erestoran_admin/models/statusNarudzbe.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class statusNarudzbeProvider extends BaseProvider<StatusNarudzbe> {
  statusNarudzbeProvider(): super("statusNarudzbe");

   @override
  StatusNarudzbe fromJson(data) {
    // TODO: implement fromJson
    return StatusNarudzbe.fromJson(data);
  }
}