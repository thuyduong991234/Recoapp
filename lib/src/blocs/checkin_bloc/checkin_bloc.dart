import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_event.dart';
import 'package:recoapp/src/blocs/checkin_bloc/checkin_state.dart';
import 'package:recoapp/src/models/checkin.dart';
import 'package:recoapp/src/resources/checkin/checkin_repository.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  //List<CheckIn> listData = [];
  CheckIn selected = null;
  int totalElements = 0;
  int page = 0;
  final _checkinRepository = CheckinRepository();

  CheckinBloc(CheckinState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  CheckinState get initialState => CheckInInitial();

  Future<CheckinState> _mapCheckInFetchToState(CheckinState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == CheckInStatus.initial) {
        final listCheckIns =
            await _checkinRepository.fetchAllCheckIns(page: page);
        List<CheckIn> listdata = listCheckIns.elementAt(1);
        totalElements = listCheckIns.elementAt(0);
        return state.copyWith(
          status: CheckInStatus.success,
          listCheckIns: listdata,
          hasReachedMax: false,
        );
      }
      final listCheckIns =
          await _checkinRepository.fetchAllCheckIns(page: ++page);
      List<CheckIn> listdata = listCheckIns.elementAt(1);
      totalElements = listCheckIns.elementAt(0);
      return listdata.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: CheckInStatus.success,
              listCheckIns: List.of(state.listCheckIns)..addAll(listdata),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: CheckInStatus.failure);
    }
  }

  @override
  Stream<CheckinState> mapEventToState(event) async* {
    if (event is GetCheckInEvent) {
      yield await _mapCheckInFetchToState(state);
    }

    if (event is SelectedCheckInEvent) {
      yield CheckInLoadingState(
          status: state.status,
          listCheckIns: state.listCheckIns,
          hasReachedMax: state.hasReachedMax);

      if (event.value)
        selected = event.checkIn;
      else
        selected = null;

      yield CheckInLoadedState(
          status: state.status,
          listCheckIns: state.listCheckIns,
          hasReachedMax: state.hasReachedMax);
    }

    if(event is SearchCheckInEvent)
    {
      yield CheckInLoadingState(
          status: state.status,
          listCheckIns: state.listCheckIns,
          hasReachedMax: state.hasReachedMax);

      yield CheckInLoadedState(
          status: state.status,
          listCheckIns: state.listCheckIns,
          hasReachedMax: state.hasReachedMax);
    }
  }
}
