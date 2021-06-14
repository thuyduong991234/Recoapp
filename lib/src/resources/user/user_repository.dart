import 'package:recoapp/src/models/diner.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/resources/user/user_api_provider.dart';

class DinerRepository {
  final dinerApiProvider = DinerApiProvider();

  Future<Diner> getDiner({int id}) => dinerApiProvider.getDiner(id: id);

  Future<String> updateProfile(
          {List<String> areas, List<int> tagid, int idUser}) =>
      dinerApiProvider.updateProfile(
          areas: areas, tagid: tagid, idUser: idUser);

  Future<String> updateAccountInfo(
          {int idUser,
          String fullname,
          String phone,
          String email,
          String address,
          DateTime dob,
          int gender}) =>
      dinerApiProvider.updateAccountInfo(
          idUser: idUser,
          fullname: fullname,
          dob: dob,
          phone: phone,
          email: email,
          address: address,
          gender: gender);

  Future<List<Object>> login({String username, String password}) =>
      dinerApiProvider.login(username: username, password: password);

  Future<String> register({String username, String password, String email}) =>
      dinerApiProvider.register(
          username: username, password: password, email: email);

  Future<List<Object>> loginSocial(
          {String fullname, String email, String avatar}) =>
      dinerApiProvider.loginSocial(
          fullname: fullname, email: email, avatar: avatar);

  Future<List<Restaurant>> GetRestaurantByPosition(
          {double latitude, double longtitude}) =>
      dinerApiProvider.GetRestaurantByPosition(
          latitude: latitude, longtitude: longtitude);
}
