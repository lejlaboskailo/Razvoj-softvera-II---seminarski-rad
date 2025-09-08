import 'package:erestoran_mobile/models/narudzba.dart';
import 'package:erestoran_mobile/models/search_result.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';

class NarudzbaProvider extends BaseProvider<Narudzba> {
  NarudzbaProvider() : super("Narudzba");

  @override
  Narudzba fromJson(data) => Narudzba.fromJson(data);

  Future<SearchResult<Narudzba>> getByUser(int userId) async {
  return await get(filter: {"korisnikId": userId});
}
}
