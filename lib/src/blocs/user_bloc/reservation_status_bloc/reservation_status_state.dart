import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/comment.dart';
import 'package:recoapp/src/models/reservation.dart';

enum ReservationStatus { initial, success, failure }

class ReservationStatusState extends Equatable {
  const ReservationStatusState({
    this.status = ReservationStatus.initial,
    this.listWaitApprove = const <Reservation>[],
    this.listApproved = const <Reservation>[],
    this.listCanceled = const <Reservation>[],
    this.listHistory = const <Reservation>[],
    this.listComments = const <Comment>[],
    this.hasReachedMaxWaitApprove = false,
    this.hasReachedMaxApproved = false,
    this.hasReachedMaxCanceled = false,
    this.hasReachedMaxHistory = false,
    this.hasReachedMaxComment = false,
  });

  final ReservationStatus status;
  final List<Reservation> listWaitApprove;
  final List<Reservation> listApproved;
  final List<Reservation> listCanceled;
  final List<Reservation> listHistory;
  final List<Comment> listComments;
  final bool hasReachedMaxWaitApprove;
  final bool hasReachedMaxApproved;
  final bool hasReachedMaxCanceled;
  final bool hasReachedMaxHistory;
  final bool hasReachedMaxComment;

  ReservationStatusState copyWith({
    ReservationStatus status,
    List<Reservation> listWaitApprove,
    List<Reservation> listApproved,
    List<Reservation> listCanceled,
    List<Reservation> listHistory,
    List<Comment> listComments,
    bool hasReachedMaxWaitApprove,
    bool hasReachedMaxApproved,
    bool hasReachedMaxCanceled,
    bool hasReachedMaxHistory,
    bool hasReachedMaxComment,
  }) {
    return ReservationStatusState(
      status: status ?? this.status,
      listWaitApprove: listWaitApprove ?? this.listWaitApprove,
      listApproved: listApproved ?? this.listApproved,
      listCanceled: listCanceled ?? this.listCanceled,
      listHistory: listHistory ?? this.listHistory,
      listComments: listComments ?? this.listComments,
      hasReachedMaxWaitApprove:
          hasReachedMaxWaitApprove ?? this.hasReachedMaxWaitApprove,
      hasReachedMaxApproved:
          hasReachedMaxApproved ?? this.hasReachedMaxApproved,
      hasReachedMaxCanceled:
          hasReachedMaxCanceled ?? this.hasReachedMaxCanceled,
      hasReachedMaxHistory: hasReachedMaxHistory ?? this.hasReachedMaxHistory,
      hasReachedMaxComment: hasReachedMaxComment ?? this.hasReachedMaxComment,
    );
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ReservationStatusLoadingState extends ReservationStatusState {
  ReservationStatusLoadingState(
      {status,
      listWaitApprove,
      listApproved,
      listCanceled,
      listHistory,
      listComments,
      hasReachedMaxWaitApprove,
      hasReachedMaxApproved,
      hasReachedMaxCanceled,
      hasReachedMaxHistory, hasReachedMaxComment})
      : super(
          status: status,
          listWaitApprove: listWaitApprove,
          listApproved: listApproved,
          listCanceled: listCanceled,
          listHistory: listHistory,
          listComments: listComments,
          hasReachedMaxWaitApprove: hasReachedMaxWaitApprove,
          hasReachedMaxApproved: hasReachedMaxApproved,
          hasReachedMaxCanceled: hasReachedMaxCanceled,
          hasReachedMaxHistory: hasReachedMaxHistory,
          hasReachedMaxComment: hasReachedMaxComment
        );
  @override
  List<Object> get props => [
        status,
        listWaitApprove,
        listApproved,
        listCanceled,
        listHistory,
        listComments,
        hasReachedMaxWaitApprove,
        hasReachedMaxApproved,
        hasReachedMaxCanceled,
        hasReachedMaxHistory,
        hasReachedMaxComment
      ];
}

class ReservationStatusLoadedState extends ReservationStatusState {
  ReservationStatusLoadedState(
      {status,
      listWaitApprove,
      listApproved,
      listCanceled,
      listHistory,
      listComments,
      hasReachedMaxWaitApprove,
      hasReachedMaxApproved,
      hasReachedMaxCanceled,
      hasReachedMaxHistory, hasReachedMaxComment})
      : super(
          status: status,
          listWaitApprove: listWaitApprove,
          listApproved: listApproved,
          listCanceled: listCanceled,
          listHistory: listHistory,
          listComments: listComments,
          hasReachedMaxWaitApprove: hasReachedMaxWaitApprove,
          hasReachedMaxApproved: hasReachedMaxApproved,
          hasReachedMaxCanceled: hasReachedMaxCanceled,
          hasReachedMaxHistory: hasReachedMaxHistory,
          hasReachedMaxComment: hasReachedMaxComment
        );
  @override
  List<Object> get props => [
        status,
        listWaitApprove,
        listApproved,
        listCanceled,
        listHistory,
        listComments,
        hasReachedMaxWaitApprove,
        hasReachedMaxApproved,
        hasReachedMaxCanceled,
        hasReachedMaxHistory,
        hasReachedMaxComment
      ];
}

class ReservationStatusInitial extends ReservationStatusState {}
