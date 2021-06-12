import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recoapp/src/ui/constants.dart';

class ImageApiProvider {
  Future<List<String>> uploadFile(List<File> photos) async {
    List<String> images = [];
    var url = Uri.parse(baseUrl + "/upload-image");

    for (int i = 0; i < photos.length; i++) {
      var request = new http.MultipartRequest('POST', url);

      request.files
          .add(await http.MultipartFile.fromPath('image', photos[i].path));

      var response = await request.send();
      var jsonResponse = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        images.add(jsonResponse['data']);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load tag');
      }
    }

    return images;
  }
}
