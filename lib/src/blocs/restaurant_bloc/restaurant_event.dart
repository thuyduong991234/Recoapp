import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class GetRestaurantEvent extends RestaurantEvent {
  final int id;
  final int idUser;
  final double latitude;
  final double longtitude;

  GetRestaurantEvent({this.id, this.idUser, this.latitude, this.longtitude});
  @override
  List<Object> get props => [id, idUser, latitude, longtitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetMoreCommentEvent extends RestaurantEvent {
  GetMoreCommentEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class ConfirmReservation extends RestaurantEvent {
  final int idVoucher;
  final DateTime time;
  final int numberPerson;
  final String code;
  final int idUser;
  final int idRes;

  ConfirmReservation({this.idVoucher, this.time, this.numberPerson, this.code, this.idUser, this.idRes});
  @override
  List<Object> get props => [idVoucher, time, numberPerson, code, idUser, idRes];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SubmitReservation extends RestaurantEvent {
  final String fullname;
  final String phonenumber;
  final String email;
  final String info;
  final BuildContext context;

  SubmitReservation(
      {this.fullname, this.phonenumber, this.email, this.info, this.context});
  @override
  List<Object> get props => [fullname, phonenumber, email, info, context];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetVoucherEvent extends RestaurantEvent {
  final int id;
  GetVoucherEvent({this.id});
  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UserLikeRestaurantEvent extends RestaurantEvent {
  final int id;
  final bool isLiked;
  final int idUser;
  final double latitude;
  final double longtitude;

  UserLikeRestaurantEvent({this.id, this.isLiked, this.idUser, this.latitude, this.longtitude});
  @override
  List<Object> get props => [id, isLiked, idUser, latitude, longtitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetRecommendRestaurantEvent extends RestaurantEvent {
  final double latitude;
  final double longtitude;

  GetRecommendRestaurantEvent({this.latitude, this.longtitude});
  @override
  List<Object> get props => [latitude, longtitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
