import 'dart:convert';

import 'package:erestoran_mobile/models/korisnik.dart';
import 'package:erestoran_mobile/models/korisnik_uloga.dart';
import 'package:erestoran_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  Korisnik? _currentUser;
  KorisnikProvider() : super("Korisnik");

  Korisnik? get currentUser => _currentUser;
  @override
  Korisnik fromJson(data) {
    // TODO: implement fromJson
    return Korisnik.fromJson(data);
  }

  Future<Korisnik?> login(String username, String password) async {
    try {
      var url = "$totalUrl/login";
      var uri = Uri.parse(url);

      var headers = createHeaders();
      var body = jsonEncode({'username': username, 'password': password});

      var response = await http.post(uri, headers: headers, body: body);

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);
        Korisnik user = fromJson(data);
        return user;
      } else {
        print("Invalid credentials");
        return null;
      }
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  Future<Korisnik> Authenticate({dynamic filter}) async {
    var url = "$totalUrl/Authenticate";

    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      Korisnik user = fromJson(data) as Korisnik;
      return user;
    } else {
      throw Exception("Pogrešno korisničko ime ili lozinka");
    }
  }

  Future<String> registerUser(
      String username, String password, String ime, String prezime) async {
    if (username.isEmpty ||
        password.isEmpty ||
        ime.isEmpty ||
        prezime.isEmpty) {
      throw Exception("All fields must be filled.");
    }

    final String apiUrl =
        '${totalUrl}/registration?username=$username&password=$password&ime=$ime&prezime=$prezime';

    final Map<String, String> headers = {
      'Authorization':
          'Basic YWRtaW46dGVzdA==', // Authorization header if needed
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      print('Raw response: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the JSON response if returned
        final responseData = json.decode(response.body);
        return 'Registration successful: ${responseData['korisnickoIme']}';
      } else {
        throw Exception('Error: ${response.body}');
      }
    } catch (error) {
      print('Error during registration: $error');
      throw Exception('Error during registration: $error');
    }
  }

  Future<void> registerUserWithRole(
    String username,
    String password,
    String ime,
    String prezime,
    String telefon,
    String email,
    int selectedRoleId, // Role ID za povezivanje sa ulogom
  ) async {
    final response = await http.post(
      Uri.parse('${totalUrl}/registration'),
      body: json.encode({
        'username': username,
        'password': password,
        'ime': ime,
        'prezime': prezime,
        'telefon': telefon,
        'email': email,
        // Dodajemo povezanost sa ulogom kroz KorisnikUloga
        'korisniciUloges': [
          {
            'ulogaId': selectedRoleId, // ID uloge koju korisnik dobija
          },
        ],
      }),
    );

    if (response.statusCode == 201) {
      // Registracija je uspela
    } else {
      throw Exception('Greška pri registraciji.');
    }
  }
}
