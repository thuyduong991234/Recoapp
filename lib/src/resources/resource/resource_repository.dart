import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/resources/resource/resource_api_provider.dart';

class ResourceRepository {
  final resourceApiProvider = ResourceApiProvider();

  Future<List<FilterItem>> getFilterItems() => resourceApiProvider.getFilterItems();

  Future<List<String>> getRestaurantNames() => resourceApiProvider.getRestaurantNames();
}