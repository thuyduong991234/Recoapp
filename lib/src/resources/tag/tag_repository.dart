import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/resources/tag/tag_api_provider.dart';

class TagRepository {
  final tagApiProvider = TagApiProvider();

  Future<List<Tag>> fetchAllTags() => tagApiProvider.fetchAllTags();
}