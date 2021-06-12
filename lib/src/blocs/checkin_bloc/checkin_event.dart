import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/checkin.dart';

abstract class CheckinEvent extends Equatable {
  const CheckinEvent();
}

class GetCheckInEvent extends CheckinEvent {
  GetCheckInEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SearchCheckInEvent extends CheckinEvent {
  final String input;

  SearchCheckInEvent({this.input});
  @override
  List<Object> get props => [input];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SelectedCheckInEvent extends CheckinEvent {
  final CheckIn checkIn;
  final bool value;

  SelectedCheckInEvent({this.checkIn, this.value});
  @override
  List<Object> get props => [checkIn, value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
