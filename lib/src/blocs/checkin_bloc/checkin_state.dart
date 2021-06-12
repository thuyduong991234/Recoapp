import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/checkin.dart';

enum CheckInStatus { initial, success, failure }

class CheckinState extends Equatable {
  const CheckinState({
    this.status = CheckInStatus.initial,
    this.listCheckIns = const <CheckIn>[],
    this.hasReachedMax = false,
  });

  final CheckInStatus status;
  final List<CheckIn> listCheckIns;
  final bool hasReachedMax;

  CheckinState copyWith({
    CheckInStatus status,
    List<CheckIn> listCheckIns,
    bool hasReachedMax,
  }) {
    return CheckinState(
      status: status ?? this.status,
      listCheckIns: listCheckIns ?? this.listCheckIns,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, listCheckIns, hasReachedMax];
}

class CheckInLoadingState extends CheckinState {
  CheckInLoadingState({status, listCheckIns, hasReachedMax}):super(status: status, listCheckIns: listCheckIns, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listCheckIns, hasReachedMax];
}

class CheckInLoadedState extends CheckinState {
  CheckInLoadedState({status, listCheckIns, hasReachedMax}):super(status: status, listCheckIns: listCheckIns, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listCheckIns, hasReachedMax];
}

class CheckInInitial extends CheckinState {}
