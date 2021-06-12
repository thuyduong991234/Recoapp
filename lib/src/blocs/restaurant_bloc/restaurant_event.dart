import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class GetRestaurantEvent extends RestaurantEvent {
  final int id;
  final int idUser;

  GetRestaurantEvent({this.id, this.idUser});
  @override
  List<Object> get props => [id, idUser];

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

  ConfirmReservation({this.idVoucher, this.time, this.numberPerson, this.code, this.idUser});
  @override
  List<Object> get props => [idVoucher, time, numberPerson, code, idUser];

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

  UserLikeRestaurantEvent({this.id, this.isLiked, this.idUser});
  @override
  List<Object> get props => [id, isLiked, idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
