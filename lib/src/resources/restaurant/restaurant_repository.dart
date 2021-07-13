import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/resources/restaurant/restaurant_api_provider.dart';

class RestaurantRepository {
  final restaurantApiProvider = RestaurantApiProvider();

  Future<Restaurant> getDetailRestaurant({int id, double longtitude, double latitude}) =>
      restaurantApiProvider.getDetailRestaurant(id: id, longtitude: longtitude, latitude: latitude);

  Future<List<Restaurant>> fetchTop10Restaurant() => restaurantApiProvider.fetchTop10Restaurant();

  Future<String> followRestaurant(
          {int idUser, int idRestaurant, bool isLiked}) =>
      restaurantApiProvider.followRestaurant(
          idUser: idUser, idRestaurant: idRestaurant, isLiked: isLiked);

  Future<List<Restaurant>> recommendRestaurantContentBased(
          {int idRestaurant, double latitude, double longtitude}) =>
      restaurantApiProvider.recommendRestaurantContentBased(
          idRestaurant: idRestaurant,
          longtitude: longtitude,
          latitude: latitude);
  
  Future<void> calRecommendItemContentBased({int idRestaurant}) =>
      restaurantApiProvider.calRecommendItemContentBased(idRestaurant: idRestaurant);

  Future<void> createHistory({int idUser, int idRestaurant}) => restaurantApiProvider.createHistory(idUser: idUser, idRestaurant: idRestaurant);
}
