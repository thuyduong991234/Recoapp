import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/ui/constants.dart';

class SearchApiProvider {
  Future<List<Object>> searchByFilter(
      List<int> areas,
      List<int> dishes,
      List<int> types,
      List<int> nation,
      String minPrice,
      String maxPrice,
      String sortBy,
      int page,
      double latitude,
      double longtitude) async {
    var direction = "ASC";
    if (sortBy == "starAverage") {
      direction = "DESC";
    }
    var url = Uri.parse(baseUrl +
        "/restaurants/search?sortable=" +
        sortBy.toString() +
        "&direction=" +
        direction +
        "&page=" +
        page.toString());

    print("url = " + url.toString());
    var body = jsonEncode(<String, dynamic>{
      'district': areas,
      'type': types,
      'dishes': dishes,
      'nation': nation,
      'minPrice': minPrice == null || minPrice == ''
          ? null
          : int.parse(minPrice.replaceAll(".", '')),
      'maxPrice': maxPrice == null || maxPrice == ''
          ? null
          : int.parse(maxPrice.replaceAll(".", '')),
      'latitude': latitude,
      'longtitude': longtitude
    });

    print("body : " + body.toString());

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'district': areas,
        'type': types,
        'dishes': dishes,
        'nation': nation,
        'minPrice': minPrice == null || minPrice == ''
            ? null
            : int.parse(minPrice.replaceAll(".", '')),
        'maxPrice': maxPrice == null || maxPrice == ''
            ? null
            : int.parse(maxPrice.replaceAll(".", '')),
        'latitude': latitude,
        'longtitude': longtitude
      }),
    );

    print("result search: " + response.body.toString());

    var jsonResponse = jsonDecode(response.body);
    print("result search: " + jsonResponse.toString());

    if (response.statusCode == 200) {
      List<Object> result = [];
      List<Restaurant> data = [];
      jsonResponse['data']["content"]
          .forEach((item) => {data.add(Restaurant.fromJsonMap(item))});
      result.add(jsonResponse['data']['totalElements']);
      result.add(data);
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> searchReview(String sortBy, int page) async {
    var url = Uri.parse(baseUrl +
        "/search/review?query=" +
        sortBy.toString() +
        "&page=" +
        page.toString());

    print("url = " + url.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Object> result = [];
      List<SimpleReview> data = [];
      jsonResponse['data']['content']
          .forEach((item) => {data.add(SimpleReview.fromJson(item))});
      result.add(jsonResponse['data']['totalElements']);
      result.add(data);
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> searchRestaurant(
      String sortBy, int page, double latitude, double longtitude) async {
    var url = Uri.parse(baseUrl +
        "/search/restaurant?query=" +
        sortBy.toString() +
        "&latitude=" +
        latitude.toString() +
        "&longtitude=" +
        longtitude.toString() +
        "&page=" +
        page.toString());

    print("url = " + url.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Object> result = [];
      List<Restaurant> data = [];
      jsonResponse['data']['content']
          .forEach((item) => {data.add(Restaurant.fromJsonMap(item))});
      result.add(jsonResponse['data']['totalElements']);
      result.add(data);
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> searchByOneTag(
      int tagId, int page, double latitude, double longtitude) async {
    var url = Uri.parse(baseUrl +
        "/restaurants/tag/" +
        tagId.toString() +
        "?latitude=" +
        latitude.toString() +
        "&longtitude=" +
        longtitude.toString() +
        "&page=" +
        page.toString());

    print("url = " + url.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Object> result = [];
      List<Restaurant> data = [];
      jsonResponse['data']['content']
          .forEach((item) => {data.add(Restaurant.fromJsonMap(item))});
      result.add(jsonResponse['data']['totalElements']);
      result.add(data);
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
