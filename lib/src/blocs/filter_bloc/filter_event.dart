import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recoapp/src/models/tag.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class EnterFilterPageEvent extends FilterEvent {
  EnterFilterPageEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class InputChangedEvent extends FilterEvent {
  final String input;

  InputChangedEvent({this.input});

  @override
  List<Object> get props => [input];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SearchByInputTextEvent extends FilterEvent {
  final String input;
  final double longtitude;
  final double latitude;

  SearchByInputTextEvent({this.input, this.longtitude, this.latitude});

  @override
  List<Object> get props => [input, longtitude, latitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetFilterEvent extends FilterEvent {
  GetFilterEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SelectedFilterItemEvent extends FilterEvent {
  final bool value;
  final int index;
  final Tag tag;

  SelectedFilterItemEvent({this.value, this.index, this.tag});
  @override
  List<Object> get props => [value, index, tag];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UnSelectedFilterItemEvent extends FilterEvent {
  final bool unSelectedAll;
  final int index;

  UnSelectedFilterItemEvent({this.unSelectedAll, this.index});
  @override
  List<Object> get props => [unSelectedAll, index];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class StartFilterEvent extends FilterEvent {
  final double longtitude;
  final double latitude;

  StartFilterEvent({this.latitude, this.longtitude});
  @override
  List<Object> get props => [latitude, longtitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class LoadMoreResultEvent extends FilterEvent {
  final int byFilter; //0: filter, 1: input, 2: tag
  final double longtitude;
  final double latitude;

  LoadMoreResultEvent({this.byFilter, this.longtitude, this.latitude});
  @override
  List<Object> get props => [byFilter, longtitude, latitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SelectedSortByEvent extends FilterEvent {
  final String sortBy;

  SelectedSortByEvent({this.sortBy});
  @override
  List<Object> get props => [sortBy];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class EnterMinPriceEvent extends FilterEvent {
  final String minPrice;

  EnterMinPriceEvent({this.minPrice});
  @override
  List<Object> get props => [minPrice];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class EnterMaxPriceEvent extends FilterEvent {
  final String maxPrice;

  EnterMaxPriceEvent({this.maxPrice});
  @override
  List<Object> get props => [maxPrice];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SearchByTagEvent extends FilterEvent {
  final Tag tag;
  final double longtitude;
  final double latitude;

  SearchByTagEvent({this.tag, this.longtitude, this.latitude});

  @override
  List<Object> get props => [tag, longtitude, latitude];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class FetchNotification extends FilterEvent {
  final int userId;

  FetchNotification({this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class FetchMoreNotification extends FilterEvent {

  final int userId;

  FetchMoreNotification({this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UpdateStatusNotification extends FilterEvent {
  final int idNoti;
  final int index;

  UpdateStatusNotification({this.idNoti, this.index});

  @override
  List<Object> get props => [idNoti, index];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class HaveNewNotification extends FilterEvent {

  final int userId;

  HaveNewNotification({this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SendTokenFCM extends FilterEvent {
  final String token;

  SendTokenFCM({this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UpdateSetNotification extends FilterEvent {
  final bool isOn;

  UpdateSetNotification({this.isOn});

  @override
  List<Object> get props => [isOn];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class DeletedInShowHome extends FilterEvent {
  final int index;
  final bool value;

  DeletedInShowHome({this.index, this.value});

  @override
  List<Object> get props => [index, value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class ReportEvent extends FilterEvent {
  final int id;
  final int type;
  final String content;
  final BuildContext context;

  ReportEvent({this.id, this.type, this.content, this.context});

  @override
  List<Object> get props => [id, type, context, content];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}