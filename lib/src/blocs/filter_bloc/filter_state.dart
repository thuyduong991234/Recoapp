import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/restaurant.dart';

enum FilterStatus { initial, success, failure, waiting }

class FilterState extends Equatable {
  const FilterState({
    this.status = FilterStatus.initial,
    this.listData = const <Restaurant>[],
    this.hasReachedMax = false,
  });

  final FilterStatus status;
  final List<Restaurant> listData;
  final bool hasReachedMax;

  FilterState copyWith({
    FilterStatus status,
    List<Restaurant> listData,
    bool hasReachedMax,
  }) {
    return FilterState(
      status: status ?? this.status,
      listData: listData ?? this.listData,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class FilterLoadingState extends FilterState {
  FilterLoadingState({status, listData, hasReachedMax})
      : super(status: status, listData: listData, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listData, hasReachedMax];
}

class FilterLoadedState extends FilterState {
  FilterLoadedState({status, listData, hasReachedMax})
      : super(status: status, listData: listData, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listData, hasReachedMax];
}

class FilterWaitingState extends FilterState {
  FilterWaitingState({status, listData, hasReachedMax})
      : super(status: status, listData: listData, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listData, hasReachedMax];
}

class FilterInitial extends FilterState {}
