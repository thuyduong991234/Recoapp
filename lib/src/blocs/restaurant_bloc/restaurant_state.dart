import 'package:equatable/equatable.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RestaurantLoadingState extends RestaurantState {
}

class RestaurantLoadedState extends RestaurantState {
}

class RestaurantInitial extends RestaurantState {
}
