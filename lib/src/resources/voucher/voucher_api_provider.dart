import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recoapp/src/models/voucher.dart';
import 'package:recoapp/src/ui/constants.dart';

class VoucherApiProvider {
  Future<List<Voucher>> fetchAllVouchers({int idRestaurant}) async {
    var url = Uri.parse(baseUrl + "/vouchers/restaurant/" + idRestaurant.toString() + "?size=10");
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Voucher> allVouchers = [];
      jsonResponse['data']['content'].forEach((item) => {allVouchers.add(Voucher.fromJsonMap(item))});
      return allVouchers;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }

  Future<Voucher> getDetailVoucher({int idVoucher}) async {
    var url = Uri.parse(baseUrl + "/vouchers/" + idVoucher.toString());
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Voucher voucher = Voucher.fromJsonMap(jsonResponse['data']);

      print(voucher.code);
      return voucher;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load tag');
    }
  }
}
