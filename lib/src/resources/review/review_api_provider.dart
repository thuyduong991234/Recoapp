import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/models/review.dart';
import 'dart:convert';

import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/ui/constants.dart';

class ReviewApiProvider {
  Future<String> createReview(String title, String content, int user, int point,
      int checkin, List<int> tags, List<String> photos) async {
    var url = Uri.parse(baseUrl + "/reviews");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'content': content,
        'restaurantId': checkin,
        'userId': 2,
        'point': point,
        'tags': tags,
        'listPhoto': photos.toString(),
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

  Future<List<Object>> fetchAllReviews({int page}) async {
    var url = Uri.parse(baseUrl + "/reviews?page=" + page.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      List<Object> result = [];
      List<SimpleReview> reviews = [];
      int totalElements = jsonResponse['data']['totalElements'];
      int totalPages = jsonResponse['data']['totalPages'];
      print("call totalElements: " + totalElements.toString());
      jsonResponse['data']['content']
          .forEach((item) => {reviews.add(SimpleReview.fromJson(item))});

      result.add(totalElements);
      result.add(reviews);
      result.add(totalPages);

      print("call reviews: " + result[1].toString());

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<Review> getDetailReview({int id}) async {
    var url = Uri.parse(baseUrl + "/reviews/" + id.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      List<Tag> tags = [];
      List<Tag> cuisine = [];

      jsonResponse['data']['tags']
          .forEach((item) => {tags.add(Tag.fromJson(item))});
      jsonResponse['data']['restaurant']['tags']
          .forEach((item) => {cuisine.add(Tag.fromJson(item))});

      Review review = Review.fromJson(jsonResponse['data']);
      String s = "";
      cuisine.map((e) => s += e.name);
      review.setTags(tags);
      review.setCuisine(s);

      return review;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<String> followReview({int idUser, int idReview, bool isLiked}) async {
    var url = Uri.parse(baseUrl + "/reviews/follow");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': idUser,
        'followableId': idReview,
        'type': isLiked == true ? 2 : 1,
      }),
    );

    if (response.statusCode == 204) {
      return "204";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<List<Object>> fetchAllReviewsByDinner({int idUser, int page}) async {
    var url = Uri.parse(baseUrl + "/reviews/user/" + idUser.toString() + "?page=" + page.toString());

    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print("Vô api:" + jsonResponse.toString());
      List<Object> result = [];
      List<SimpleReview> reviews = [];
      int totalElements = jsonResponse['data']['totalElements'];
      int totalPages = jsonResponse['data']['totalPages'];
      print("call totalElements: " + totalElements.toString());
      jsonResponse['data']['content']
          .forEach((item) => {reviews.add(SimpleReview.fromJson(item))});

      result.add(totalElements);
      result.add(reviews);
      result.add(totalPages);

      print("call reviews: " + result[1].toString());

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
