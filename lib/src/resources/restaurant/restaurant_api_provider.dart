import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/restaurant.dart';
import 'dart:convert';

import 'package:recoapp/src/ui/constants.dart';

class RestaurantApiProvider {
  Future<Restaurant> getDetailRestaurant({int id}) async {

    var url = Uri.parse(baseUrl + "/restaurants/" + id.toString());

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

  Future<String> followRestaurant({int idUser, int idRestaurant, bool isLiked}) async {

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
}
