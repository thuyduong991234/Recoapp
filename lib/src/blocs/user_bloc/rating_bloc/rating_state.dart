import 'package:equatable/equatable.dart';

abstract class RatingState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class RatingLoadingState extends RatingState {
}

class RatingLoadedState extends RatingState {
}

class RatingInitial extends RatingState {
}
