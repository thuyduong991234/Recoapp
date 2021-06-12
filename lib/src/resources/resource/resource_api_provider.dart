import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/filter_item.dart';
import 'dart:convert';

import 'package:recoapp/src/ui/constants.dart';

class ResourceApiProvider {
  Future<List<FilterItem>> getFilterItems() async {
    var url = Uri.parse(baseUrl + "/resources");
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    print("code = " + response.statusCode.toString());

    if (response.statusCode == 200) {
      List<FilterItem> resources = [];
      jsonResponse['data'].forEach((item) => {resources.add(FilterItem.fromJsonMap(item))});

      return resources;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<String>> getRestaurantNames() async {
    var url = Uri.parse(baseUrl + "/restaurants/name");
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<String> resources = (jsonResponse['data'] as List<dynamic>).cast<String>();

      return resources;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
