import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/models/diner.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'dart:convert';

import 'package:recoapp/src/ui/constants.dart';

class DinerApiProvider {
  Future<Diner> getDiner({int id}) async {
    var url = Uri.parse(baseUrl + "/users/t/diners/" + id.toString());

    print("url login = " + url.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      Diner diner = Diner.fromJsonMap(jsonResponse["data"]);

      return diner;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Restaurant>> GetRestaurantByPosition({double latitude, double longtitude}) async {
    var url = Uri.parse(baseUrl + "/restaurants/nearby?latitude=" + latitude.toString() + "&longtitude=" + longtitude.toString());

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

  Future<String> updateProfile(
      {List<String> areas, List<int> tagid, int idUser}) async {
    var url = Uri.parse(baseUrl + "/users/t/diners/profile");

    print("url = " + url.toString());
    print("areas = " + areas.toString());
    print("tagid = " + tagid.toString());
    print("idUser = " + idUser.toString());

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'userId': idUser, 'tagId': tagid, 'areas': areas}),
    );

    print(response.statusCode.toString());

    if (response.statusCode == 204) {
      return "204";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<String> updateAccountInfo(
      {int idUser,
      String fullname,
      String phone,
      String email,
      String address,
      DateTime dob,
      int gender}) async {
    var url = Uri.parse(baseUrl + "/users/t/diners");

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idUser,
        'fullName': fullname,
        'dob': dob.toIso8601String(),
        'phone': phone,
        'email': email,
        'addressDetail': address,
        'gender': gender
      }),
    );

    print(response.statusCode.toString());

    if (response.statusCode == 204) {
      return "204";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> login({String username, String password}) async {
    var url = Uri.parse(baseUrl + "/login");

    print("url login = " + url.toString());
    print("username = " + username);
    print("password = " + password);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("id = " + jsonResponse['data']['id'].toString());
      print("token = " + jsonResponse['data']['token']);
      List<Object> result = [];
      result.add(jsonResponse['data']['id']);
      result.add(jsonResponse['data']['token']);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<String> register(
      {String username, String password, String email}) async {
    var url = Uri.parse(baseUrl + "/register");

    print("url login = " + url.toString());
    print("username = " + username);
    print("password = " + password);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
        'email': email,
        'role': "USER"
      }),
    );

    if (response.statusCode == 201) {
      return "201";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> loginSocial({String fullname, String email, String avatar}) async {
    var url = Uri.parse(baseUrl + "/login-social");

    print("url login = " + url.toString());
    print("username = " + fullname);
    print("password = " + email);
    print("avatar = " + avatar);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'fullName': fullname,
        'email': email,
        'avatar': avatar
      }),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("id = " + jsonResponse['data']['id'].toString());
      print("token = " + jsonResponse['data']['token']);
      List<Object> result = [];
      result.add(jsonResponse['data']['id']);
      result.add(jsonResponse['data']['token']);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
