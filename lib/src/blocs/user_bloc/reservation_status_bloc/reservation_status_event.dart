import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ReservationStatusEvent extends Equatable {
  const ReservationStatusEvent();
}

class GetReservationEvent extends ReservationStatusEvent {
  final int idUser;

  GetReservationEvent({this.idUser});
  @override
  List<Object> get props => [idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetMoreEvent extends ReservationStatusEvent {
  final int type;
   final int idUser;

  GetMoreEvent({this.idUser, this.type});
  @override
  List<Object> get props => [idUser, type];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

