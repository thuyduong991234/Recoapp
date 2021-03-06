import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/resources/search/search_api_provider.dart';

class SearchRepository {
  final searchApiProvider = SearchApiProvider();

  Future<List<Object>> searchByFilter(
          List<int> areas,
          List<int> dishes,
          List<int> types,
          List<int> nation,
          String minPrice,
          String maxPrice,
          String sortBy,
          int page,
          double latitude,
          double longtitude) =>
      searchApiProvider.searchByFilter(
          areas, dishes, types, nation, minPrice, maxPrice, sortBy, page, latitude, longtitude);

  Future<List<Object>> searchReview(String sortBy, int page) => searchApiProvider.searchReview(sortBy, page);

  Future<List<Object>> searchRestaurant(String sortBy, int page, double latitude,
          double longtitude) => searchApiProvider.searchRestaurant(sortBy, page, latitude, longtitude);

  Future<List<Object>> searchByOneTag(
      int tagId, int page, double latitude, double longtitude) => searchApiProvider.searchByOneTag(tagId, page, latitude, longtitude);
}
