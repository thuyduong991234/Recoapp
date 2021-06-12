import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_event.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_state.dart';
import 'package:recoapp/src/resources/comment/comment_repository.dart';
import 'package:recoapp/src/resources/image/image_repository.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  List<File> listPhotos = [];

  final _imageRepository = ImageRepository();
  final _commentRepository = CommentRepository();

  RatingBloc(RatingState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  RatingState get initialState => RatingInitial();

  @override
  Stream<RatingState> mapEventToState(event) async* {
    if (event is UploadImageRatingEvent) {
      yield RatingLoadingState();
      print("file = " + listPhotos.length.toString());

      listPhotos.add(event.image);

      print("file = " + listPhotos.length.toString());

      yield RatingLoadedState();
    }

    if (event is DeleteImageRatingEvent) {
      yield RatingLoadingState();

      listPhotos.removeAt(event.index);

      yield RatingLoadedState();
    }

    if (event is SubmitRatingEvent) {
      yield RatingLoadingState();

      print("star2 = " + event.starFood.toString());
      print("star3 = " + event.starService.toString());
      print("star4 = " + event.starAmbious.toString());
      print("star5 = " + event.starNoise.toString());
      print("comment = " + event.comment);
      print("comment = " + event.idRestaurant.toString());
      print("comment = " + event.idReservation.toString());

      List<String> images = null;
      if (event.photos.length > 0) {
        images = await _imageRepository.fetchImageUrl(event.photos);
      }

      String resultCode = await _commentRepository.createComment(
          event.starFood,
          event.starService,
          event.starAmbious,
          event.starNoise,
          event.comment.isEmpty ? null : event.comment,
          event.idRestaurant,
          event.idReservation,
          event.idUser,
          images);

      if (resultCode == "201") {
        listPhotos = [];
        Fluttertoast.showToast(
            msg: "Đăng thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      }
      Navigator.of(event.context).pop();

      yield RatingLoadedState();
    }
  }
}
