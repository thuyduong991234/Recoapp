import 'dart:io';
import 'package:recoapp/src/resources/image/image_api_provider.dart';

class ImageRepository {
  final imageApiProvider = ImageApiProvider();

  Future<List<String>> fetchImageUrl(List<File> photos) => imageApiProvider.uploadFile(photos);
}