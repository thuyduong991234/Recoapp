import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/resources/restaurant/restaurant_api_provider.dart';

class RestaurantRepository {
  final restaurantApiProvider = RestaurantApiProvider();

  Future<Restaurant> getDetailRestaurant({int id}) =>
      restaurantApiProvider.getDetailRestaurant(id: id);

  Future<String> followRestaurant({int idUser, int idRestaurant, bool isLiked}) =>
      restaurantApiProvider.followRestaurant(
          idUser: idUser, idRestaurant: idRestaurant, isLiked: isLiked);
}
