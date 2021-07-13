import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/models/comment.dart';
import 'package:recoapp/src/models/diner.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/resources/comment/comment_repository.dart';
import 'package:recoapp/src/resources/restaurant/restaurant_repository.dart';
import 'package:recoapp/src/resources/user/user_repository.dart';
import 'package:recoapp/src/resources/voucher/voucher_repository.dart';
import 'package:recoapp/src/resources/reservation/reservation_repository.dart';
import 'package:recoapp/src/models/voucher.dart';
import 'package:recoapp/src/models/reservation.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  Restaurant data = null;
  List<Voucher> listVouchers = null;
  Reservation reservation;
  Voucher currentVoucher;
  List<Comment> listComment = [];
  bool hasReachedMax = false;
  int page = 0;
  int totalPage = 0;
  int numberLiked = 0;
  bool isFollowed = false;
  Marker marker = null;
  List<Restaurant> recommendRestaurant = [];

  final _restaurantRepository = RestaurantRepository();
  final _voucherRepository = VoucherRepository();
  final _reservationRepsitory = ReservationRepository();
  final _commentRepository = CommentRepository();
  final _dinerRepository = DinerRepository();

  RestaurantBloc(RestaurantState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  RestaurantState get initialState => RestaurantInitial();

  @override
  Stream<RestaurantState> mapEventToState(event) async* {
    if (event is GetRestaurantEvent) {
      print("event.id " + event.id.toString());
      data = await _restaurantRepository.getDetailRestaurant(
          id: event.id, latitude: event.latitude, longtitude: event.longtitude);
      numberLiked = data.userLikeCount;
      listVouchers =
          await _voucherRepository.fetchAllVouchers(idRestaurant: data.id);
      List<Object> result = await _commentRepository.fetchCommentsByRestaurant(
          idRestaurant: data.id, page: page);
      listComment = result[0];
      if (result[1] == page + 1) hasReachedMax = true;

      if (event.idUser != null) {
        Diner diner = await _dinerRepository.getDiner(id: event.idUser);
        for (int i = 0; i < diner.favoriteRestaurants.length; i++) {
          if (diner.favoriteRestaurants[i].id == data.id) {
            isFollowed = true;
            break;
          }
        }
      } else {
        isFollowed = false;
      }

      marker = new Marker(
        markerId: MarkerId(data.id.toString()),
        position: LatLng(data.latitude, data.longtitude),
        infoWindow: InfoWindow(title: data.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      );

      await _restaurantRepository.createHistory(
          idUser: event.idUser, idRestaurant: data.id);

      yield RestaurantLoadedState();
    }

    if (event is GetMoreCommentEvent) {
      yield RestaurantLoadingState();
      if (!hasReachedMax) {
        List<Object> result = await _commentRepository
            .fetchCommentsByRestaurant(idRestaurant: data.id, page: ++page);

        List<Comment> listComments = result[0];

        if (listComments.isEmpty)
          hasReachedMax = true;
        else
          listComment = List.of(listComment)..addAll(listComments);
        yield RestaurantLoadedState();
      }
    }

    if (event is GetVoucherEvent) {
      yield RestaurantLoadingState();

      currentVoucher =
          await _voucherRepository.getDetailVoucher(idVoucher: event.id);
      marker = new Marker(
        markerId: MarkerId(currentVoucher.idRestaurant.toString()),
        position: LatLng(currentVoucher.latitude, currentVoucher.longtitude),
        infoWindow: InfoWindow(title: currentVoucher.nameRestaurant),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      );

      yield RestaurantLoadedState();
    }

    if (event is ConfirmReservation) {
      yield RestaurantLoadingState();
      reservation = new Reservation();
      reservation.idRestaurant = data.id;
      reservation.idVoucher = event.idVoucher;
      reservation.numberPerson = event.numberPerson;
      reservation.time = event.time;
      reservation.idUser = event.idUser;
      reservation.code = event.code;
      yield RestaurantLoadedState();
    }

    if (event is SubmitReservation) {
      yield RestaurantLoadingState();
      if (event.fullname == null ||
          event.fullname.isEmpty ||
          event.phonenumber == null ||
          event.phonenumber.isEmpty ||
          event.email == null ||
          event.email.isEmpty) {
        Fluttertoast.showToast(
            msg: "Hãy nhập đầy đủ thông tin người đặt!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        reservation.fullname = event.fullname;
        reservation.phoneNumber = event.phonenumber;
        reservation.email = event.email;
        reservation.additionalInfo = event.info.isEmpty ? null : event.info;

        print("reservation = " +
            reservation.idUser.toString() +
            " - " +
            reservation.idRestaurant.toString() +
            reservation.idVoucher.toString() +
            reservation.time.toString());
        String resultCode =
            await _reservationRepsitory.createReservation(reservation);

        if (resultCode == "201") {
          Fluttertoast.showToast(
              msg: "Gửi yêu cầu đặt chỗ thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
        }
        Navigator.of(event.context).pop();
      }
      yield RestaurantLoadedState();
    }

    if (event is UserLikeRestaurantEvent) {
      if (event.idUser == null) {
        Fluttertoast.showToast(
            msg: "Bạn cần đăng nhập để thực hiện chức năng này!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
        yield RestaurantLoadingState();
      } else {
        event.isLiked == true ? isFollowed = false : isFollowed = true;
        yield RestaurantLoadingState();
        String code = await _restaurantRepository.followRestaurant(
            idUser: event.idUser,
            idRestaurant: event.id,
            isLiked: event.isLiked);
        if (code == "204") {
          Restaurant result = await _restaurantRepository.getDetailRestaurant(
              id: event.id,
              longtitude: event.longtitude,
              latitude: event.latitude);
          numberLiked = result.userLikeCount;
          Diner diner = await _dinerRepository.getDiner(id: event.idUser);
          for (int i = 0; i < diner.favoriteRestaurants.length; i++) {
            if (diner.favoriteRestaurants[i].id == data.id) {
              isFollowed = true;
              break;
            }
          }
        }
        yield RestaurantLoadedState();
      }
    }

    if (event is GetRecommendRestaurantEvent) {
      yield RestaurantLoadingState();

      if (recommendRestaurant.length <= 0) {
        /*await _restaurantRepository.calRecommendItemContentBased(
            idRestaurant: data.id);*/
        recommendRestaurant =
            await _restaurantRepository.recommendRestaurantContentBased(
                idRestaurant: data.id,
                longtitude: event.longtitude,
                latitude: event.latitude);
      }

      yield RestaurantLoadedState();
    }
  }
}
