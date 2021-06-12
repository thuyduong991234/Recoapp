import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recoapp/src/models/checkin.dart';
import 'package:recoapp/src/models/tag.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class GetReviewEvent extends ReviewEvent {
  GetReviewEvent();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class GetDetailReviewEvent extends ReviewEvent {
  final int id;
  final int idUser;

  GetDetailReviewEvent({this.id, this.idUser});
  @override
  List<Object> get props => [id, idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UploadImageReviewEvent extends ReviewEvent {
  final File image;

  UploadImageReviewEvent({this.image});
  @override
  List<Object> get props => [image];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class DeleteImageReviewEvent extends ReviewEvent {
  final int index;

  DeleteImageReviewEvent({this.index});
  @override
  List<Object> get props => [index];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SubmitReviewEvent extends ReviewEvent {
  final BuildContext context;
  final String title;
  final String content;
  final String point;
  final CheckIn checkIn;
  final List<Tag> tags;
  final List<File> photos;
  final int idUser;

  SubmitReviewEvent({this.context, this.title, this.content, this.point, this.checkIn, this.tags, this.photos, this.idUser});
  @override
  List<Object> get props => [context, title, content, point, checkIn, tags, photos, idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UserLikeReviewEvent extends ReviewEvent {
  final int id;
  final bool isLiked;
  final int idUser;

  UserLikeReviewEvent({this.id, this.isLiked, this.idUser});
  @override
  List<Object> get props => [id, isLiked, idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class LikeRestaurantEvent extends ReviewEvent {
  final int id;
  final bool isLiked;
  final int idUser;

  LikeRestaurantEvent({this.id, this.isLiked, this.idUser});
  @override
  List<Object> get props => [id, isLiked, idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SearchReviewEvent extends ReviewEvent {
  final String searchBy;
  final bool startSearch;

  SearchReviewEvent({this.searchBy, this.startSearch});
  @override
  List<Object> get props => [searchBy, startSearch];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
