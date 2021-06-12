import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recoapp/src/models/reservation.dart';
import 'package:recoapp/src/ui/constants.dart';

class ReservationApiProvider {
  Future<String> createReservation(Reservation reservation) async {
    var url = Uri.parse(baseUrl + "/reservations");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'restaurantId': reservation.idRestaurant,
        'userId': reservation.idUser,
        'voucherId': reservation.idVoucher,
        'timeComing': reservation.time.toIso8601String(),
        'partySize': reservation.numberPerson,
        'fullName': reservation.fullname,
        'email': reservation.email,
        'phone': reservation.phoneNumber,
        'note': reservation.additionalInfo
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

  Future<List<Object>> fetchReservationByType({int idUser, int page, int type}) async {
    
    var url = Uri.parse(baseUrl + "/reservations/type/" + type.toString() + "/user/" +
        idUser.toString() +
        "?page=" +
        page.toString());
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Object> listResult = [];
      List<Reservation> data = [];
      jsonResponse['data']['content']
          .forEach((item) => {data.add(Reservation.fromJson(item))});

      listResult.add(data);
      listResult.add(jsonResponse['data']['totalPages']);

      return listResult;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
