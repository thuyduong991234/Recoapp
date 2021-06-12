import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();
}

class GetDetailRatingEvent extends RatingEvent {
  final int id;

  GetDetailRatingEvent({this.id});
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class UploadImageRatingEvent extends RatingEvent {
  final File image;

  UploadImageRatingEvent({this.image});
  @override
  List<Object> get props => [image];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class DeleteImageRatingEvent extends RatingEvent {
  final int index;

  DeleteImageRatingEvent({this.index});
  @override
  List<Object> get props => [index];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}

class SubmitRatingEvent extends RatingEvent {
  final BuildContext context;
  final int starFood;
  final int starService;
  final int starAmbious;
  final int starNoise;
  final String comment;
  final List<File> photos;
  final int idRestaurant;
  final int idReservation;
  final int idUser;

  SubmitRatingEvent({this.context, this.starFood, this.starService, this.starAmbious, this.starNoise, this.comment, this.photos, this.idReservation, this.idRestaurant, this.idUser});
  @override
  List<Object> get props => [context, starFood, starService, starAmbious, starNoise, comment, photos, idReservation, idRestaurant, idUser];

  @override
  String toString() => 'ProductButtonPressed { ... }';
}
