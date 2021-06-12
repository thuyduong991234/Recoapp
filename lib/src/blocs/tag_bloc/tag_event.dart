import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/tag.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

class GetTagEvent extends TagEvent {
  GetTagEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SearchTagEvent extends TagEvent {
  final String input;

  SearchTagEvent({this.input});
  @override
  List<Object> get props => [input];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SelectedTagEvent extends TagEvent {
  final Tag tag;
  final bool value;

  SelectedTagEvent({this.tag, this.value});
  @override
  List<Object> get props => [tag, value];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
