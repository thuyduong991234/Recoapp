import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/models/notification.dart';
import 'package:recoapp/src/models/tag.dart';
import 'dart:convert';

import 'package:recoapp/src/ui/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResourceApiProvider {
  Future<List<FilterItem>> getFilterItems() async {
    var url = Uri.parse(baseUrl + "/resources");
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    print("code = " + response.statusCode.toString());

    if (response.statusCode == 200) {
      List<FilterItem> resources = [];
      jsonResponse['data']
          .forEach((item) => {resources.add(FilterItem.fromJsonMap(item))});

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
      List<String> resources =
          (jsonResponse['data'] as List<dynamic>).cast<String>();

      return resources;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<String> sendTokenFCM(String token) async {
    var url = Uri.parse(baseUrl + "/fcm/sub?token=" + token);
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 204) {
      return "204";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> fetchNotification(int userId, int page) async {
    var url = Uri.parse(baseUrl +
        "/noti?userId=" +
        userId.toString() +
        "&size=15&page=" +
        page.toString());
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    print("url noti " + url.toString());

    if (response.statusCode == 200) {
      List<Object> result = [];
      List<Noti> data = [];
      final prefs = await SharedPreferences.getInstance();

      Noti noti;
      var counter;

      jsonResponse['data']['content'].forEach((item) => {
            noti = Noti.fromJsonMap(item),
            counter = prefs.getInt(noti.id.toString()) ?? 0,
            counter != 0 ? noti.setStatus(true) : noti.setStatus(false),
            data.add(noti),
          });

      result.add(data);
      result.add(jsonResponse['data']['totalPages']);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<int> report({int id, String content, int type}) async {
    var url = Uri.parse(baseUrl + "/reports");

    print("url login = " + url.toString());
    print("id = " + id.toString());
    print("content = " + content);
    print("type = " + type.toString());

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'reportableId': id,
        'content': content,
        'type': type,
      }),
    );

    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
