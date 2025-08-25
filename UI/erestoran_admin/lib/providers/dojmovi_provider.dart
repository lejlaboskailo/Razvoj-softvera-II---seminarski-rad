
import 'package:erestoran_admin/models/dojmovi.dart';
import 'package:erestoran_admin/providers/base_provider.dart';

class DojmoviProvider extends BaseProvider<Dojmovi> {
  DojmoviProvider(): super("Dojmovi");

   @override
  Dojmovi fromJson(data) {
    return Dojmovi.fromJson(data);
  }
}