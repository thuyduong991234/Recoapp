import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoginEvent extends UserEvent {
  final String username;
  final String password;
  final BuildContext context;
  
  LoginEvent({this.username, this.password, this.context});
  @override
  List<Object> get props => [username, password, context];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class LoginWithGoogleEvent extends UserEvent {
  final BuildContext context;
  
  LoginWithGoogleEvent({this.context});
  @override
  List<Object> get props => [context];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class InitialPositionEvent extends UserEvent {
  final double latitude;
  final double longtitude;
  
  InitialPositionEvent({this.latitude, this.longtitude});
  @override
  List<Object> get props => [latitude, longtitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetRestaurantByPositionEvent extends UserEvent {
  final double latitude;
  final double longtitude;
  
  GetRestaurantByPositionEvent({this.latitude, this.longtitude});
  @override
  List<Object> get props => [latitude, longtitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class LogoutEvent extends UserEvent {
  final BuildContext context;
  
  LogoutEvent({this.context});
  @override
  List<Object> get props => [context];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class RegisterEvent extends UserEvent {
  final String username;
  final String password;
  final String email;
  final BuildContext context;
  
  RegisterEvent({this.username, this.password, this.email, this.context});
  @override
  List<Object> get props => [username, password, email, context];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetDinerEvent extends UserEvent {
  final int idUser;
  
  GetDinerEvent({this.idUser});
  @override
  List<Object> get props => [idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetUserReviewsEvent extends UserEvent {
  final int id;
  
  GetUserReviewsEvent({this.id});
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetMoreUserReviewsEvent extends UserEvent {
  final int id;
  
  GetMoreUserReviewsEvent({this.id});
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}


class UserLikeRestaurantEvent extends UserEvent {
  final int id;
  final bool isLiked;

  UserLikeRestaurantEvent({this.id, this.isLiked});
  @override
  List<Object> get props => [id, isLiked];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UserLikeReviewEvent extends UserEvent {
  final int id;
  final bool isLiked;

  UserLikeReviewEvent({this.id, this.isLiked});
  @override
  List<Object> get props => [id, isLiked];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SelectedAreasEvent extends UserEvent {
  final int id;
  final bool value;

  SelectedAreasEvent({this.id, this.value});
  @override
  List<Object> get props => [id, value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SelectedOtherTagEvent extends UserEvent {
  final int id;
  final bool value;

  SelectedOtherTagEvent({this.id, this.value});
  @override
  List<Object> get props => [id, value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UpdateProfileEvent extends UserEvent {
  BuildContext context;

  UpdateProfileEvent({this.context});
  @override
  List<Object> get props => [context];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UpdateAccountInfoEvent extends UserEvent {
  BuildContext context;
  String fullname;
  String address;
  String email;
  String phone;
  DateTime dob;
  int gender;

  UpdateAccountInfoEvent({this.context, this.fullname, this.dob, this.address, this.email, this.gender, this.phone});
  @override
  List<Object> get props => [context, fullname, dob, address, email, gender, phone];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}




