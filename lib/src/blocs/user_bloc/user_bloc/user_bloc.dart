import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/models/diner.dart';
import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/models/restaurant.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/resources/reservation/reservation_repository.dart';
import 'package:recoapp/src/resources/resource/resource_repository.dart';
import 'package:recoapp/src/resources/review/review_repository.dart';
import 'package:recoapp/src/resources/user/user_repository.dart';
import 'package:recoapp/src/ui/page/user/account_page.dart';
import 'package:recoapp/src/ui/page/user/login_page.dart';
import 'package:recoapp/src/ui/page/user/profile_page.dart';
import 'package:recoapp/src/ui/tab/tab_navigator.dart';
import 'package:recoapp/src/ui/tab/user_page.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<File> listPhotos = [];
  List<SimpleReview> listReviews = null;
  List<FilterItem> listFilterItem = null;
  int page = 0;
  bool hasReachedMax = false;
  int totalPage = 0;
  List<String> areas = [];
  List<int> tagId = [];
  double longtitude = 0;
  double latitude = 0;
  List<Restaurant> nearBy = [];
  Set<Marker> markers = Set();
  List<Restaurant> recomendForYou = [];
  List<Restaurant> recommendCollab = [];
  List<Restaurant> recommendHistory = [];
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';

  Diner diner = null;

  String token = null;

  final _dinerRepository = DinerRepository();
  final _reviewRepository = ReviewRepository();
  final _resourceRepository = ResourceRepository();
  final _reservationRepository = ReservationRepository();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  UserBloc(UserState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is InitialPositionEvent) {
      yield UserLoadingState();
      longtitude = event.longtitude;
      latitude = event.latitude;
      yield UserLoadedState();
    }

    if (event is LoadNearBy) {
      yield UserLoadingState();
      nearBy = await _dinerRepository.GetRestaurantByPosition(
          latitude: latitude, longtitude: longtitude);

      for (int i = 0; i < nearBy.length; i++) {
        Marker marker = new Marker(
          markerId: MarkerId(nearBy[i].id.toString()),
          position: LatLng(nearBy[i].latitude, nearBy[i].longtitude),
          infoWindow: InfoWindow(title: nearBy[i].name),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        );
        markers.add(marker);
      }
      yield UserLoadedState();
    }

    if (event is GetDinerEvent) {
      yield UserLoadingState();
      diner = await _dinerRepository.getDiner(id: event.idUser);
      recomendForYou = await _dinerRepository.recommendRestaurantContentBased(
          idUser: event.idUser, latitude: latitude, longtitude: longtitude);
      await _dinerRepository.calRecommendRestaurantCollab(idUser: event.idUser);
      recommendCollab = await _dinerRepository.recommendRestaurantCollab(
          idUser: event.idUser, latitude: latitude, longtitude: longtitude);
      recommendHistory = await _dinerRepository.fetchRestaurantHistoryByUserId(
          idUser: diner.id, latitude: latitude, longtitude: longtitude);

      yield UserLoadedState();
    }

    if (event is LogoutEvent) {
      yield UserLoadingState();
      listPhotos = [];
      listReviews = null;
      listFilterItem = null;
      page = 0;
      hasReachedMax = false;
      totalPage = 0;
      areas = [];
      tagId = [];
      diner = null;
      token = null;
      await _auth.signOut();
      await _googleSignIn.signOut();
      yield UserLoadedState();
    }

    if (event is LoginEvent) {
      yield UserLoadingState();

      if (event.username.trim() == "" || event.password.trim() == "") {
        Navigator.of(event.context).pop();

        Fluttertoast.showToast(
            msg: "H??y nh???p ?????y ????? th??ng tin!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        List<Object> resultLogin = await _dinerRepository.login(
            username: event.username, password: event.password);

        if (resultLogin.elementAt(0) == "401") {
          Navigator.of(event.context).pop();

          Fluttertoast.showToast(
              msg: "M???t kh???u kh??ng ????ng. H??y th??? l???i!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
        } else {
          token = resultLogin.elementAt(1).toString();

          diner = await _dinerRepository.getDiner(
              id: int.parse(resultLogin.elementAt(0).toString()));
          listFilterItem = await _resourceRepository.getFilterItems();

          areas =
              diner.activeAreaIds != null ? diner.activeAreaIds.split("&") : [];

          if (diner.tags != null && diner.tags.length > 0) {
            for (int i = 0; i < diner.tags.length; i++) {
              tagId.add(diner.tags[i].id);
            }
          }

          FirebaseMessaging messaging = FirebaseMessaging.instance;

          final tokenFCM = await messaging.getToken();

          await _dinerRepository.sendUserTokenFCM(tokenFCM, diner.id);

          if (diner.fullname == "Ch??a c???p nh???t" &&
              diner.phone == "Ch??a c???p nh???t" &&
              diner.address == "Ch??a c???p nh???t") {
            Navigator.of(event.context).pop();

            Fluttertoast.showToast(
                msg: "????ng nh???p th??nh c??ng!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                timeInSecForIosWeb: 5);

            Navigator.push(
              event.context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          } else {
            recomendForYou =
                await _dinerRepository.recommendRestaurantContentBased(
                    idUser: diner.id,
                    latitude: latitude,
                    longtitude: longtitude);
            recommendCollab = await _dinerRepository.recommendRestaurantCollab(
                idUser: diner.id, latitude: latitude, longtitude: longtitude);
            recommendHistory =
                await _dinerRepository.fetchRestaurantHistoryByUserId(
                    idUser: diner.id,
                    latitude: latitude,
                    longtitude: longtitude);

            Navigator.of(event.context).pop();

            Fluttertoast.showToast(
                msg: "????ng nh???p th??nh c??ng!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                timeInSecForIosWeb: 5);

            Navigator.push(
              event.context,
              MaterialPageRoute(
                  builder: (context) => TabNavigator(
                        index: 3,
                      )),
            );
          }

          yield UserLoadedState();
        }
      }
    }

    if (event is LoginWithGoogleEvent) {
      yield UserLoadingState();

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = (await _auth.signInWithCredential(credential));

      _user = result.user;

      List<Object> resultLogin = await _dinerRepository.loginSocial(
          fullname: _user.displayName,
          email: _user.email,
          avatar: _user.photoURL);

      token = resultLogin.elementAt(1).toString();

      diner = await _dinerRepository.getDiner(
          id: int.parse(resultLogin.elementAt(0).toString()));
      listFilterItem = await _resourceRepository.getFilterItems();

      areas = diner.activeAreaIds != null ? diner.activeAreaIds.split("&") : [];

      if (diner.tags != null && diner.tags.length > 0) {
        for (int i = 0; i < diner.tags.length; i++) {
          tagId.add(diner.tags[i].id);
        }
      }

      FirebaseMessaging messaging = FirebaseMessaging.instance;

      final tokenFCM = await messaging.getToken();

      await _dinerRepository.sendUserTokenFCM(tokenFCM, diner.id);

      if (diner.fullname == "Ch??a c???p nh???t" ||
          (diner.phone == "Ch??a c???p nh???t" &&
              diner.address == "Ch??a c???p nh???t")) {
        Navigator.of(event.context).pop();

        Fluttertoast.showToast(
            msg: "????ng nh???p th??nh c??ng!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            timeInSecForIosWeb: 10);

        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
      } else {
        recomendForYou = await _dinerRepository.recommendRestaurantContentBased(
            idUser: diner.id, latitude: latitude, longtitude: longtitude);
        recommendCollab = await _dinerRepository.recommendRestaurantCollab(
            idUser: diner.id, latitude: latitude, longtitude: longtitude);
        recommendHistory =
            await _dinerRepository.fetchRestaurantHistoryByUserId(
                idUser: diner.id, latitude: latitude, longtitude: longtitude);

        Navigator.of(event.context).pop();

        Fluttertoast.showToast(
            msg: "????ng nh???p th??nh c??ng!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            timeInSecForIosWeb: 10);

        Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => TabNavigator(
                    index: 3,
                  )),
        );
      }

      yield UserLoadedState();
    }

    if (event is RegisterEvent) {
      yield UserLoadingState();
      RegExp regExp = new RegExp(pattern);
      if (event.username.trim() == "" ||
          event.password.trim() == "" ||
          event.email.trim() == "") {
        Fluttertoast.showToast(
            msg: "H??y nh???p ?????y ????? th??ng tin!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (!regExp.hasMatch(event.password)) {
        Fluttertoast.showToast(
            msg:
                "M???t kh???u ph???i ch???a ??t nh???t 8 k?? t???, m???t k?? t??? in hoa, m???t k?? t??? th?????ng, m???t k?? t??? s???.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        String resultRegister = await _dinerRepository.register(
            username: event.username,
            password: event.password,
            email: event.email);

        if (resultRegister == "201") {
          Fluttertoast.showToast(
              msg: "????ng k?? th??nh c??ng!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);

          Navigator.of(event.context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
          yield UserLoadedState();
        } else if (resultRegister == "400") {
          Fluttertoast.showToast(
              msg: "Email/Username ???? t???n t???i.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
        }
      }
    }

    if (event is GetUserReviewsEvent) {
      yield UserLoadingState();
      page = 0;
      hasReachedMax = false;

      List<Object> result = await _reviewRepository.fetchAllReviewsByDinner(
          idUser: diner.id, page: page);

      listReviews = result[1];

      if (listReviews.length == result[0]) hasReachedMax = true;

      yield UserLoadedState();
    }

    if (event is GetMoreUserReviewsEvent) {
      yield UserLoadingState();
      if (!hasReachedMax) {
        List<Object> result = await _reviewRepository.fetchAllReviewsByDinner(
            idUser: diner.id, page: ++page);

        List<SimpleReview> listReviewsMore = result[1];

        if (listReviewsMore.isEmpty)
          hasReachedMax = true;
        else
          listReviews = List.of(listReviews)..addAll(listReviewsMore);
        yield UserLoadedState();
      }
    }

    if (event is SelectedAreasEvent) {
      yield UserLoadingState();

      if (event.value) {
        areas.add(event.id.toString());
      } else {
        areas.remove(event.id.toString());
      }

      yield UserLoadedState();
    }

    if (event is SelectedOtherTagEvent) {
      yield UserLoadingState();

      if (event.value) {
        tagId.add(event.id);
      } else {
        tagId.remove(event.id);
      }

      yield UserLoadedState();
    }

    if (event is UpdateProfileEvent) {
      yield UserLoadingState();

      if (areas.length <= 0) {
        Fluttertoast.showToast(
            msg: "H??y th??m khu v???c b???n quan t??m v?? th??? l???i",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (tagId.length <= 0) {
        Fluttertoast.showToast(
            msg: "H??y th??m s??? th??ch c???a b???n v?? th??? l???i",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        String code = await _dinerRepository.updateProfile(
            tagid: tagId, areas: areas, idUser: diner.id);

        if (code == "204") {
          Fluttertoast.showToast(
              msg: "C???p nh???t s??? th??ch th??nh c??ng",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
        }

        diner = await _dinerRepository.getDiner(id: diner.id);

        areas = diner.activeAreaIds.split("&");

        if (diner.tags != null && diner.tags.length > 0) {
          for (int i = 0; i < diner.tags.length; i++) {
            tagId.add(diner.tags[i].id);
          }
        }

        Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => TabNavigator(
                    index: 3,
                  )),
        );

        yield UserLoadedState();
      }
    }

    if (event is UpdateAccountInfoEvent) {
      yield UserLoadingState();

      if (event.fullname == null ||
          (event.fullname.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "T??n c???a b???n kh??ng ???????c b??? tr???ng",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.phone == null ||
          (event.phone.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "S??? ??i???n tho???i c???a b???n kh??ng ???????c b??? tr???ng",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.email == null ||
          (event.email.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "Email c???a b???n kh??ng ???????c b??? tr???ng",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.address == null ||
          (event.address.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "?????a ch??? c???a b???n kh??ng ???????c b??? tr???ng",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        String code = await _dinerRepository.updateAccountInfo(
            idUser: diner.id,
            fullname: event.fullname,
            email: event.email,
            phone: event.phone,
            dob: event.dob,
            gender: event.gender,
            address: event.address);

        if (code == "204") {
          Fluttertoast.showToast(
              msg: "C???p nh???t th??ng tin th??nh c??ng",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
        }

        diner = await _dinerRepository.getDiner(id: diner.id);

        areas =
            diner.activeAreaIds != null ? diner.activeAreaIds.split("&") : [];

        if (diner.tags != null && diner.tags.length > 0) {
          for (int i = 0; i < diner.tags.length; i++) {
            tagId.add(diner.tags[i].id);
          }
        }

        if (diner.tags == null || diner.tags.length <= 0) {
          Navigator.push(
            event.context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        } else {
          Navigator.of(event.context).pop();
        }

        yield UserLoadedState();
      }
    }

    if (event is CalRecommendContentBasedEvent) {
      yield UserLoadingState();
      await _dinerRepository.calRecommendRestaurantContentBased(
          tagid: tagId, areas: areas, idUser: diner.id);
      recomendForYou = await _dinerRepository.recommendRestaurantContentBased(
          idUser: diner.id, latitude: latitude, longtitude: longtitude);
      yield UserLoadedState();
    }

    if (event is CalRecommendCollabEvent) {
      yield UserLoadingState();
      await _dinerRepository.calRecommendRestaurantCollab(idUser: diner.id);
      recommendCollab = await _dinerRepository.recommendRestaurantCollab(
          idUser: diner.id, latitude: latitude, longtitude: longtitude);
      yield UserLoadedState();
    }

    if (event is FetchRecommendNoUser) {
      yield UserLoadingState();
      recomendForYou = await _dinerRepository.recommendRestaurantNoUser(
          latitude: latitude, longtitude: longtitude);

      yield UserLoadedState();
    }

    if (event is FetchRestaurantHistory) {
      yield UserLoadingState();
      if (diner != null) {
        recommendHistory =
            await _dinerRepository.fetchRestaurantHistoryByUserId(
                idUser: diner.id, latitude: latitude, longtitude: longtitude);
      } else {
        recommendHistory = await _dinerRepository.fetchRestaurantHistoryByIp(
            latitude: latitude, longtitude: longtitude);
      }

      yield UserLoadedState();
    }

    if (event is ChangePasswordEvent) {
      yield UserLoadingState();
      RegExp regExp = new RegExp(pattern);

      if (event.confirmPassword == "" ||
          event.newPassword == "" ||
          event.currentPassword == "") {
        Fluttertoast.showToast(
            msg: "H??y nh???p ?????y ????? th??ng tin.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (!regExp.hasMatch(event.newPassword)) {
        Fluttertoast.showToast(
            msg:
                "M???t kh???u ph???i ch???a ??t nh???t 8 k?? t???, m???t k?? t??? in hoa, m???t k?? t??? th?????ng, m???t k?? t??? s???.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.confirmPassword != event.newPassword) {
        Fluttertoast.showToast(
            msg: "X??c nh???n l???i m???t kh???u m???i kh??ng kh???p. H??y th??? l???i!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        List<Object> result = await _dinerRepository.updatePassword(
            userId: diner.id,
            currentPassword: event.currentPassword,
            newpassword: event.newPassword);
        if (result[0] == 400) {
          Fluttertoast.showToast(
              msg: "Password hi???n t???i kh??ng ????ng.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
        } else {
          token = result[1].toString();
          Fluttertoast.showToast(
              msg: "C???p nh???t m???t kh???u th??nh c??ng!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              timeInSecForIosWeb: 5);
          Navigator.of(event.context).pop();
          yield UserLoadedState();
        }
      }
    }
  }
}
