import 'dart:convert';

import 'package:all_about_clubs/models/club.dart';
import 'package:all_about_clubs/shared/constants.dart';
import 'package:http/http.dart' as http;

class BackendService {
  Future<List<Club>> getListOfClubs() async {
    const authority = BASE_URI;
    const path = "hiring/clubs.json";
    final uri = Uri.https(authority, path);

    final response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=unicode'
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Club> allClubs = (json.decode(response.body) as List)
          .map((i) => Club.fromJson(i))
          .toList();
      return allClubs;
    } else {
      // TODO: Better error-handling
      throw Exception('Failed to get list of clubs.');
    }
  }
}
