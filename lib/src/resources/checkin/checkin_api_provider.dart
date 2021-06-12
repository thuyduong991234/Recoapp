import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/checkin.dart';
import 'dart:convert';

import 'package:recoapp/src/ui/constants.dart';

class CheckInApiProvider {
  Future<List<Object>> fetchAllCheckIns({int page}) async {
    var url = Uri.parse(baseUrl + "/restaurants/checkin?page=" + page.toString());
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      List<Object> result = [];
      List<CheckIn> checkins = [];
      int totalElements = jsonResponse['data']['totalElements'];
      jsonResponse['data']['content']
          .forEach((item) => {checkins.add(CheckIn.fromJson(item))});

      result.add(totalElements);
      result.add(checkins);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
