import 'package:equatable/equatable.dart';
import 'package:recoapp/src/models/simple_review.dart';

enum ReviewStatus { initial, success, failure }
class ReviewState extends Equatable {
  const ReviewState({
    this.status = ReviewStatus.initial,
    this.listData = const <SimpleReview>[],
    this.hasReachedMax = false,
  });

  final ReviewStatus status;
  final List<SimpleReview> listData;
  final bool hasReachedMax;

  ReviewState copyWith({
    ReviewStatus status,
    List<SimpleReview> listData,
    bool hasReachedMax,
  }) {
    return ReviewState(
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

class ReviewLoadingState extends ReviewState {
  ReviewLoadingState({status, listData, hasReachedMax}):super(status: status, listData: listData, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listData, hasReachedMax];
}

class ReviewLoadedState extends ReviewState {
  ReviewLoadedState({status, listData, hasReachedMax}):super(status: status, listData: listData, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listData, hasReachedMax];
}

class ReviewWaitUploadState extends ReviewState {
  ReviewWaitUploadState({status, listData, hasReachedMax}):super(status: status, listData: listData, hasReachedMax: hasReachedMax);
  @override
  List<Object> get props => [status, listData, hasReachedMax];
}

class ReviewInitial extends ReviewState {
}
