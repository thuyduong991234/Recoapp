import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/ui/constants.dart';

class TagApiProvider {
  Future<List<Tag>> fetchAllTags() async {
    var url = Uri.parse(baseUrl + "/resources/tags");
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Tag> allTags = [];
      jsonResponse['data'].forEach((item) => {allTags.add(Tag.fromJson(item))});
      return allTags;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
