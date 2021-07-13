import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/resources/resource/resource_api_provider.dart';

class ResourceRepository {
  final resourceApiProvider = ResourceApiProvider();

  Future<List<FilterItem>> getFilterItems() =>
      resourceApiProvider.getFilterItems();

  Future<List<String>> getRestaurantNames() =>
      resourceApiProvider.getRestaurantNames();

  Future<String> sendTokenFCM(String token) =>
      resourceApiProvider.sendTokenFCM(token);

  Future<List<Object>> fetchNotification(int userId, int page) =>
      resourceApiProvider.fetchNotification(userId, page);

  Future<int> report({int id, String content, int type}) =>
      resourceApiProvider.report(id: id, content: content, type: type);
}
