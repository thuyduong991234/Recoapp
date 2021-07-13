import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/models/diner.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/models/review.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/resources/restaurant/restaurant_repository.dart';
import 'package:recoapp/src/resources/search/search_repository.dart';
import 'package:recoapp/src/resources/user/user_repository.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/resources/image/image_repository.dart';
import 'package:recoapp/src/resources/review/review_repository.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  List<File> listPhotos = [];
  Review review = null;
  int totalElements = 0;
  int totalPage = 0;
  int page = 0;
  int numberRestaurantLiked = 0;
  int numberReviewLiked = 0;
  bool isLiked = false;
  bool isLikedRestaurant = false;
  Diner diner = null;
  bool isSearch = false;

  final _imageRepository = ImageRepository();
  final _reviewRepository = ReviewRepository();
  final _restaurantRepository = RestaurantRepository();
  final _dinerRepository = DinerRepository();
  final _searchRepository = SearchRepository();

  ReviewBloc(ReviewState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  ReviewState get initialState => ReviewInitial();

  Future<ReviewState> _mapReviewFetchToState(
      ReviewState state, bool isRefresh) async {
    print("vô 2");
    if (state.hasReachedMax) return state;
    try {
      print("vô 3");
      if (state.status == ReviewStatus.initial || isRefresh) {
        print("vô 4");
        final reviews = await _reviewRepository.fetchAllReviews(page: page);
        List<SimpleReview> listdata = reviews.elementAt(1);
        totalElements = reviews.elementAt(0);
        totalPage = reviews.elementAt(2);
        return ReviewLoadedState(
          status: ReviewStatus.success,
          listData: listdata,
          hasReachedMax: false,
        );
      }

      final reviews = await _reviewRepository.fetchAllReviews(page: ++page);
      List<SimpleReview> listdata = reviews.elementAt(1);
      totalElements = reviews.elementAt(0);
      print("list data = " + listdata.length.toString());
      List<SimpleReview> a = List.of(state.listData)..addAll(listdata);
      print("list data = " + a.length.toString());
      return listdata.isEmpty
          ? ReviewLoadedState(
              status: ReviewStatus.success,
              listData: a,
              hasReachedMax: true,
            )
          : ReviewLoadedState(
              status: ReviewStatus.success,
              listData: a,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ReviewStatus.failure);
    }
  }

  Future<ReviewState> _mapReviewSearchToState(
      ReviewState state, String searchBy) async {
    if (state.hasReachedMax) return state;
    try {
      if (page == 0) {
        final reviews = await _searchRepository.searchReview(searchBy, page);
        List<SimpleReview> listdata = reviews.elementAt(1);
        totalElements = reviews.elementAt(0);
        if (listdata.length == totalElements)
          return state.copyWith(
            status: ReviewStatus.success,
            listData: listdata,
            hasReachedMax: true,
          );
        else
          return state.copyWith(
            status: ReviewStatus.success,
            listData: listdata,
            hasReachedMax: false,
          );
      }

      final reviews = await _searchRepository.searchReview(searchBy, ++page);
      List<SimpleReview> listdata = reviews.elementAt(1);
      totalElements = reviews.elementAt(0);
      List<SimpleReview> a = List.of(state.listData)..addAll(listdata);
      return listdata.isEmpty
          ? ReviewLoadedState(
              status: ReviewStatus.success,
              listData: a,
              hasReachedMax: true,
            )
          : ReviewLoadedState(
              status: ReviewStatus.success,
              listData: a,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ReviewStatus.failure);
    }
  }

  @override
  Stream<ReviewState> mapEventToState(event) async* {
    if (event is GetReviewEvent) {
      isSearch = false;
      yield await _mapReviewFetchToState(state, true);
    }

    if (event is GetReviewAfterSearchEvent) {
      yield ReviewLoadingState(
          status: state.status, listData: state.listData, hasReachedMax: false);
      page = 0;
      isSearch = false;
      yield await _mapReviewFetchToState(state, true);
    }

    if (event is SearchReviewEvent) {
      if (event.startSearch) {
        page = 0;
        yield ReviewLoadingState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: false);
      }
      isSearch = true;
      yield await _mapReviewSearchToState(state, event.searchBy);
    }

    if (event is GetMoreReviewEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      if (isSearch) {
        yield await _mapReviewSearchToState(state, event.textSearch);
      } else {
        yield await _mapReviewFetchToState(state, false);
      }
    }

    if (event is GetDetailReviewEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      isLiked = false;
      isLikedRestaurant = false;

      review = await _reviewRepository.getDetailReview(id: event.id);
      numberRestaurantLiked = review.likeRestaurant;
      numberReviewLiked = review.like;

      if (event.idUser != null) {
        diner = await _dinerRepository.getDiner(id: event.idUser);
        for (int i = 0; i < diner.favoriteRestaurants.length; i++) {
          if (diner.favoriteRestaurants[i].id == review.idRestaurant) {
            isLikedRestaurant = true;
            break;
          }
        }

        for (int i = 0; i < diner.favoriteReviews.length; i++) {
          if (diner.favoriteReviews[i].id == review.id) {
            isLiked = true;
            break;
          }
        }
      } else {
        isLiked = false;
        isLikedRestaurant = false;
      }

      yield ReviewLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is UploadImageReviewEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      print("file = " + listPhotos.length.toString());

      listPhotos.add(event.image);

      print("file = " + listPhotos.length.toString());

      yield ReviewLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is DeleteImageReviewEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);

      listPhotos.removeAt(event.index);

      yield ReviewLoadedState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
    }

    if (event is SubmitReviewEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      List<int> idTags = [];

      if (event.tags != null || event.tags.length != 0) {
        idTags = event.tags.map((e) => e.id).toList();
      }

      print("title = " + event.title);
      print("content = " + event.content);
      print("point = " + event.point);
      print("photo = " + event.photos.toString());
      print("checkin = " + event.checkIn?.id.toString());
      print("tag = " + idTags.toString());

      if (event.title == null || event.title.isEmpty) {
        //send = false;
        Fluttertoast.showToast(
            msg: "Hãy thêm tiêu đề và thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else if (event.content == null || event.content.isEmpty) {
        //send = false;
        Fluttertoast.showToast(
            msg: "Hãy thêm nội dung và thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else if (event.point == null || event.point.isEmpty) {
        //end = false;
        Fluttertoast.showToast(
            msg: "Hãy thêm điểm đánh giá và thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else if (event.photos == null || event.photos.length == 0) {
        //send = false;
        Fluttertoast.showToast(
            msg: "Hãy thêm hình ảnh chứng thực và thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else if (event.checkIn == null) {
        //send = false;
        Fluttertoast.showToast(
            msg: "Hãy thêm địa điểm check - in và thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else {
        Navigator.of(event.context).pop();
        List<String> images =
            await _imageRepository.fetchImageUrl(event.photos);

        String resultCode = await _reviewRepository.createReview(
            event.title,
            event.content,
            event.idUser,
            int.tryParse(event.point),
            event.checkIn.id,
            idTags,
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
          page = 0;
          final reviews = await _reviewRepository.fetchAllReviews(page: page);
          List<SimpleReview> listdata = reviews.elementAt(1);
          totalElements = reviews.elementAt(0);
          totalPage = reviews.elementAt(2);
          yield state.copyWith(
            status: ReviewStatus.success,
            listData: listdata,
            hasReachedMax: listdata.length == totalElements ? true : false,
          );
        }
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      }
    }

    if (event is LikeRestaurantEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      if (event.idUser != null) {
        isLikedRestaurant = false;
        String code = await _restaurantRepository.followRestaurant(
            idUser: event.idUser,
            idRestaurant: event.id,
            isLiked: event.isLiked);
        if (code == "204") {
          review = await _reviewRepository.getDetailReview(id: review.id);
          numberRestaurantLiked = review.likeRestaurant;
          diner = await _dinerRepository.getDiner(id: event.idUser);
          for (int i = 0; i < diner.favoriteRestaurants.length; i++) {
            if (diner.favoriteRestaurants[i].id == review.idRestaurant) {
              isLikedRestaurant = true;
              break;
            }
          }
        }
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else {
        Fluttertoast.showToast(
            msg: "Bạn cần đăng nhập để thực hiện chức năng này!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      }
    }

    if (event is UserLikeReviewEvent) {
      yield ReviewLoadingState(
          status: state.status,
          listData: state.listData,
          hasReachedMax: state.hasReachedMax);
      if (event.idUser != null) {
        String code = await _reviewRepository.followReview(
            idUser: event.idUser, idReview: event.id, isLiked: event.isLiked);
        isLiked = false;
        if (code == "204") {
          review = await _reviewRepository.getDetailReview(id: review.id);
          numberReviewLiked = review.like;
          diner = await _dinerRepository.getDiner(id: event.idUser);
          for (int i = 0; i < diner.favoriteReviews.length; i++) {
            if (diner.favoriteReviews[i].id == review.id) {
              isLiked = true;
              break;
            }
          }
        }
        yield ReviewLoadedState(
            status: state.status,
            listData: state.listData,
            hasReachedMax: state.hasReachedMax);
      } else {
        Fluttertoast.showToast(
            msg: "Bạn cần đăng nhập để thực hiện chức năng này!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      }
    }
  }
}
