import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/tag.dart';

abstract class TagState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class TagLoadingState extends TagState {
}

class TagLoadedState extends TagState {
}

class Initial extends TagState {
}
