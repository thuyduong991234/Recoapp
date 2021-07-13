import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/restaurant.dart';
import 'dart:convert';

import 'package:recoapp/src/ui/constants.dart';

class RestaurantApiProvider {
  Future<Restaurant> getDetailRestaurant(
      {int id, double longtitude, double latitude}) async {
    var url = Uri.parse(baseUrl +
        "/restaurants/" +
        id.toString() +
        "?longtitude=" +
        longtitude.toString() +
        "&latitude=" +
        latitude.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      Restaurant restaurant = Restaurant.fromJsonMap(jsonResponse['data']);

      return restaurant;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Restaurant>> fetchTop10Restaurant() async {
    var url = Uri.parse(baseUrl + "/restaurants/top10");
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Restaurant> result = [];
      jsonResponse['data']
          .forEach((item) => {result.add(Restaurant.fromJsonMap(item))});
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<String> followRestaurant(
      {int idUser, int idRestaurant, bool isLiked}) async {
    var url = Uri.parse(baseUrl + "/restaurants/follow");
    print("vô " + isLiked.toString());
    print("vô" + idUser.toString());
    print("vô" + idRestaurant.toString());

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': idUser,
        'followableId': idRestaurant,
        'type': isLiked == true ? 2 : 1,
      }),
    );

    if (response.statusCode == 204) {
      print("vô");
      return "204";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Restaurant>> recommendRestaurantContentBased(
      {int idRestaurant, double latitude, double longtitude}) async {
    var url = Uri.parse(baseUrl +
        "/restaurants/restaurant-recom?restaurantId=" +
        idRestaurant.toString() +
        "&longtitude=" +
        longtitude.toString() +
        "&latitude=" +
        latitude.toString());

    print("url login = " + url.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      List<Restaurant> data = [];
      jsonResponse['data']
          .forEach((item) => {data.add(Restaurant.fromJsonMap(item))});

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<void> calRecommendItemContentBased({int idRestaurant}) async {
    var url =
        Uri.parse(baseUrl + "/ml/icb?restaurantId=" + idRestaurant.toString());

    print("url = " + url.toString());
    print("id = " + idRestaurant.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 204) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("Vô api:");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<void> createHistory({int idUser, int idRestaurant}) async {
    final urlIp = Uri.parse('https://api.ipify.org');

    final responseIp = await http.get(urlIp);

    if (responseIp.statusCode == 200) {
      final ip = responseIp.body;

      print("ip = " + ip.toString());
      print("id user = " + idUser.toString());

      var uri = Uri.parse(baseUrl + "/history");

      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userId": idUser == null ? -1 : idUser,
          "restaurantId": idRestaurant,
          "ip": ip.toString()
        }),
      );

      if (response.statusCode == 201) {
        return "201";
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load tag');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
