import 'package:equatable/equatable.dart';
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
  SearchByInputTextEvent({this.input});

  @override
  List<Object> get props => [input];

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
  StartFilterEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class LoadMoreResultEvent extends FilterEvent {
  final bool byFilter;

  LoadMoreResultEvent({this.byFilter});
  @override
  List<Object> get props => [byFilter];

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
