import 'dart:convert';
import 'dart:io';

import 'package:all_about_clubs/helper/error_toaster.dart';
import 'package:all_about_clubs/models/club.dart';
import 'package:all_about_clubs/shared/constants.dart';
import 'package:http/http.dart' as http;

class BackendService {
  Future<List<Club>?> getListOfClubs() async {
    const authority = BASE_URI;
    const path = "hiring/clubs.json";
    final uri = Uri.https(authority, path);

    try {
      final response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8'
      });
      if (response.statusCode == 200) {
        List<Club> allClubs =
            (json.decode(utf8.decode(response.bodyBytes)) as List)
                .map((i) => Club.fromJson(i))
                .toList();
        return allClubs;
      } else {
        throw HttpException('${response.statusCode}');
      }
    } on SocketException {
      ErrorToaster().showErrorToast(
          "You seem to be offline, please make sure you have a connection to the internet!");
    } on HttpException {
      ErrorToaster()
          .showErrorToast("It seems there are some problems with the request.");
    } on FormatException {
      ErrorToaster().showErrorToast(
          "It seems there are some problems with the request, please try again later");
    } catch (e) {
      ErrorToaster().showErrorToast(
          "It seems there are some problems with the request, please try again later");
    }
    return null;
  }
}
