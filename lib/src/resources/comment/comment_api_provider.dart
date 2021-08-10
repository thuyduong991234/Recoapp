import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/comment.dart';
import 'dart:convert';
import 'package:recoapp/src/ui/constants.dart';

class CommentApiProvider {
  Future<String> createComment(
      int starFood,
      int starService,
      int starAmbious,
      int starNoise,
      String comment,
      int idRestaurant,
      int idReservation,
      int idUser,
      List<String> photos) async {
    var url = Uri.parse(baseUrl + "/comments");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'content': comment,
        'userId': idUser,
        'restaurantId': idRestaurant,
        'reservationId': idReservation,
        'foodStar': starFood,
        'serviceStar': starService,
        'aimbianceStar': starAmbious,
        'noiseStar': starNoise,
        'listPhoto': photos == null ? null : photos.toString(),
      }),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return "201";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> fetchCommentsByUser({int page, int idUser}) async {
    var url = Uri.parse(baseUrl +
        "/comments/user/" +
        idUser.toString() +
        "?page=" +
        page.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      List<Object> result = [];
      List<Comment> data = [];
      jsonResponse['data']['content']
          .forEach((item) => {data.add(Comment.fromJson(item))});

      result.add(data);
      result.add(jsonResponse['data']['totalPages']);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> fetchCommentsByRestaurant(
      {int page, int idRestaurant}) async {
    var url = Uri.parse(baseUrl +
        "/comments/restaurant/" +
        idRestaurant.toString() +
        "?page=" +
        page.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());

      List<Object> result = [];
      List<Comment> data = [];

      jsonResponse['data']['content']
          .forEach((item) => {data.add(Comment.fromJson(item))});

      for (int i = 0; i < data.length; i++) {
        var urlTwo =
            Uri.parse(baseUrl + "/users/badge/" + data[i].user.id.toString());
        final responseTwo = await http.get(urlTwo,
            headers: {'Accept': 'application/json; charset=UTF-8'});
        var jsonResponseTwo = jsonDecode(responseTwo.body);

        if (responseTwo.statusCode == 200) {
          data[i].user.point = jsonResponseTwo["data"]["point"];
          data[i].user.level = jsonResponseTwo["data"]["level"];
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load tag');
        }
      }

      result.add(data);
      result.add(jsonResponse['data']['totalPages']);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<Comment> getDetailComment({int id}) async {
    var url = Uri.parse(baseUrl + "/comments/" + id.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Comment comment = Comment.fromJson(jsonResponse['data']);

      return comment;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
