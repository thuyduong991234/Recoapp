import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UserLoadingState extends UserState {
}

class UserLoadedState extends UserState {
}

class UserInitial extends UserState {
}
