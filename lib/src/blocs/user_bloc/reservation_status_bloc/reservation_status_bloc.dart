import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_event.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_state.dart';
import 'package:recoapp/src/models/comment.dart';
import 'package:recoapp/src/models/reservation.dart';
import 'package:recoapp/src/resources/comment/comment_repository.dart';
import 'package:recoapp/src/resources/reservation/reservation_repository.dart';

class ReservationStatusBloc
    extends Bloc<ReservationStatusEvent, ReservationStatusState> {
  int pageWaitApprove = 0;
  int pageApproved = 0;
  int pageCanceled = 0;
  int pageHistory = 0;
  int pageRating = 0;

  final _reservationRepsitory = ReservationRepository();
  final _commentRepository = CommentRepository();

  ReservationStatusBloc(ReservationStatusState initialState)
      : super(initialState);

  @override
  // TODO: implement initialState
  ReservationStatusState get initialState => ReservationStatusInitial();

  @override
  Stream<ReservationStatusState> mapEventToState(event) async* {
    if (event is GetReservationEvent) {
      yield await _mapResultFetchToState(state, event.idUser);
    }

    if (event is GetMoreEvent) {
      yield ReservationStatusLoadingState(
          status: state.status,
          listWaitApprove: state.listWaitApprove,
          listApproved: state.listApproved,
          listCanceled: state.listCanceled,
          listHistory: state.listHistory,
          listComments: state.listComments,
          hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
          hasReachedMaxApproved: state.hasReachedMaxApproved,
          hasReachedMaxCanceled: state.hasReachedMaxCanceled,
          hasReachedMaxHistory: state.hasReachedMaxHistory,
          hasReachedMaxComment: state.hasReachedMaxComment);

      yield await _mapResultFetchMoreToState(state, event.type, event.idUser);
    }

    if (event is CancelledReservationEvent) {
      yield ReservationStatusLoadingState(
          status: state.status,
          listWaitApprove: state.listWaitApprove,
          listApproved: state.listApproved,
          listCanceled: state.listCanceled,
          listHistory: state.listHistory,
          listComments: state.listComments,
          hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
          hasReachedMaxApproved: state.hasReachedMaxApproved,
          hasReachedMaxCanceled: state.hasReachedMaxCanceled,
          hasReachedMaxHistory: state.hasReachedMaxHistory,
          hasReachedMaxComment: state.hasReachedMaxComment);

      String result = await _reservationRepsitory.cancelledReservation(
          idReservation: event.id);

      if (result == "204") {
        Fluttertoast.showToast(
            msg: "Hủy yêu cầu đặt chỗ thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);

        if (event.typeList == 0) {
          Reservation re = state.listWaitApprove.elementAt(event.index);

          List<Reservation> a = List.of(state.listWaitApprove)..removeAt(event.index);

          List<Reservation> b = List.of(state.listCanceled)..add(re);

          yield ReservationStatusLoadedState(
            status: state.status,
            listWaitApprove: a,
            listApproved: state.listApproved,
            listCanceled: b,
            listHistory: state.listHistory,
            listComments: state.listComments,
            hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
            hasReachedMaxApproved: state.hasReachedMaxApproved,
            hasReachedMaxCanceled: state.hasReachedMaxCanceled,
            hasReachedMaxHistory: state.hasReachedMaxHistory,
            hasReachedMaxComment: state.hasReachedMaxComment);
        } else {
          Reservation re = state.listApproved.elementAt(event.index);

          List<Reservation> a = List.of(state.listApproved)..removeAt(event.index);
          List<Reservation> b = List.of(state.listCanceled)..add(re);

          yield ReservationStatusLoadedState(
            status: state.status,
            listWaitApprove: state.listWaitApprove,
            listApproved: a,
            listCanceled: b,
            listHistory: state.listHistory,
            listComments: state.listComments,
            hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
            hasReachedMaxApproved: state.hasReachedMaxApproved,
            hasReachedMaxCanceled: state.hasReachedMaxCanceled,
            hasReachedMaxHistory: state.hasReachedMaxHistory,
            hasReachedMaxComment: state.hasReachedMaxComment);
        }

        
      }
    }
  }

  Future<ReservationStatusState> _mapResultFetchToState(
      ReservationStatusState state, int idUser) async {
    try {
      List<Object> waitApprove =
          await _reservationRepsitory.fetchReservationByType(
              idUser: idUser, type: 1, page: pageWaitApprove);
      List<Object> approved = await _reservationRepsitory
          .fetchReservationByType(idUser: idUser, type: 2, page: pageApproved);
      List<Object> canceled = await _reservationRepsitory
          .fetchReservationByType(idUser: idUser, type: 3, page: pageCanceled);
      List<Object> history = await _reservationRepsitory.fetchReservationByType(
          idUser: idUser, type: 4, page: pageHistory);
      List<Object> comment = await _commentRepository.fetchCommentsByUser(
          idUser: idUser, page: pageRating);

      return state.copyWith(
        status: ReservationStatus.success,
        listWaitApprove: waitApprove[0],
        listApproved: approved[0],
        listCanceled: canceled[0],
        listHistory: history[0],
        listComments: comment[0],
        hasReachedMaxWaitApprove: (pageWaitApprove + 1) == waitApprove[1],
        hasReachedMaxApproved: (pageApproved + 1) == approved[1],
        hasReachedMaxCanceled: (pageCanceled + 1) == canceled[1],
        hasReachedMaxHistory: (pageHistory + 1) == history[1],
        hasReachedMaxComment: (pageRating + 1) == comment[1],
      );
    } on Exception {
      return state.copyWith(status: ReservationStatus.failure);
    }
  }

  Future<ReservationStatusState> _mapResultFetchMoreToState(
      ReservationStatusState state, int type, int idUser) async {
    if (type == 1) {
      if (state.hasReachedMaxWaitApprove) {
        return state;
      }
      try {
        List<Object> waitApprove =
            await _reservationRepsitory.fetchReservationByType(
                idUser: idUser, type: type, page: ++pageWaitApprove);

        List<Reservation> data = waitApprove[0];

        List<Reservation> a = List.of(state.listWaitApprove)..addAll(data);
        return data.isEmpty
            ? state.copyWith(hasReachedMaxWaitApprove: true)
            : ReservationStatusLoadedState(
                status: ReservationStatus.success,
                listWaitApprove: a,
                listApproved: state.listApproved,
                listCanceled: state.listCanceled,
                listHistory: state.listHistory,
                listComments: state.listComments,
                hasReachedMaxComment: state.hasReachedMaxComment,
                hasReachedMaxWaitApprove: false,
                hasReachedMaxApproved: state.hasReachedMaxApproved,
                hasReachedMaxCanceled: state.hasReachedMaxCanceled,
                hasReachedMaxHistory: state.hasReachedMaxHistory,
              );
      } on Exception {
        return state.copyWith(status: ReservationStatus.failure);
      }
    }

    if (type == 2) {
      if (state.hasReachedMaxApproved) return state;
      try {
        List<Object> approved =
            await _reservationRepsitory.fetchReservationByType(
                idUser: idUser, type: type, page: ++pageApproved);
        List<Reservation> data = approved[0];

        List<Reservation> a = List.of(state.listApproved)..addAll(data);
        return data.isEmpty
            ? state.copyWith(hasReachedMaxApproved: true)
            : ReservationStatusLoadedState(
                status: ReservationStatus.success,
                listApproved: a,
                listWaitApprove: state.listWaitApprove,
                listCanceled: state.listCanceled,
                listHistory: state.listHistory,
                listComments: state.listComments,
                hasReachedMaxComment: state.hasReachedMaxComment,
                hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
                hasReachedMaxApproved: false,
                hasReachedMaxCanceled: state.hasReachedMaxCanceled,
                hasReachedMaxHistory: state.hasReachedMaxHistory,
              );
      } on Exception {
        return state.copyWith(status: ReservationStatus.failure);
      }
    }

    if (type == 3) {
      if (state.hasReachedMaxCanceled) return state;
      try {
        List<Object> canceled =
            await _reservationRepsitory.fetchReservationByType(
                idUser: idUser, type: type, page: ++pageCanceled);

        List<Reservation> data = canceled[0];

        List<Reservation> a = List.of(state.listCanceled)..addAll(data);
        return data.isEmpty
            ? state.copyWith(hasReachedMaxCanceled: true)
            : ReservationStatusLoadedState(
                status: ReservationStatus.success,
                listWaitApprove: state.listWaitApprove,
                listApproved: state.listApproved,
                listCanceled: a,
                listHistory: state.listHistory,
                listComments: state.listComments,
                hasReachedMaxComment: state.hasReachedMaxComment,
                hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
                hasReachedMaxApproved: state.hasReachedMaxApproved,
                hasReachedMaxCanceled: false,
                hasReachedMaxHistory: state.hasReachedMaxHistory,
              );
      } on Exception {
        return state.copyWith(status: ReservationStatus.failure);
      }
    }

    if (type == 4) {
      if (state.hasReachedMaxHistory) return state;
      try {
        List<Object> history =
            await _reservationRepsitory.fetchReservationByType(
                idUser: idUser, type: 1, page: ++pageHistory);

        List<Reservation> data = history[0];

        List<Reservation> a = List.of(state.listHistory)..addAll(data);
        return data.isEmpty
            ? state.copyWith(hasReachedMaxHistory: true)
            : ReservationStatusLoadedState(
                status: ReservationStatus.success,
                listWaitApprove: state.listWaitApprove,
                listApproved: state.listApproved,
                listCanceled: state.listCanceled,
                listHistory: a,
                listComments: state.listComments,
                hasReachedMaxComment: state.hasReachedMaxComment,
                hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
                hasReachedMaxApproved: state.hasReachedMaxApproved,
                hasReachedMaxCanceled: state.hasReachedMaxCanceled,
                hasReachedMaxHistory: false,
              );
      } on Exception {
        return state.copyWith(status: ReservationStatus.failure);
      }
    }

    if (type == 5) {
      if (state.hasReachedMaxComment) return state;
      try {
        List<Object> comment = await _commentRepository.fetchCommentsByUser(
            idUser: idUser, page: ++pageRating);
        List<Comment> data = comment[0];

        List<Comment> a = List.of(state.listComments)..addAll(data);
        return data.isEmpty
            ? state.copyWith(hasReachedMaxComment: true)
            : ReservationStatusLoadedState(
                status: ReservationStatus.success,
                listWaitApprove: state.listWaitApprove,
                listApproved: state.listApproved,
                listCanceled: state.listCanceled,
                listHistory: state.listHistory,
                listComments: a,
                hasReachedMaxWaitApprove: state.hasReachedMaxWaitApprove,
                hasReachedMaxApproved: state.hasReachedMaxApproved,
                hasReachedMaxCanceled: state.hasReachedMaxCanceled,
                hasReachedMaxHistory: state.hasReachedMaxHistory,
                hasReachedMaxComment: false);
      } on Exception {
        return state.copyWith(status: ReservationStatus.failure);
      }
    }
  }
}
