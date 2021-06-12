import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/models/diner.dart';
import 'package:recoapp/src/models/filter_item.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/resources/resource/resource_repository.dart';
import 'package:recoapp/src/resources/review/review_repository.dart';
import 'package:recoapp/src/resources/user/user_repository.dart';
import 'package:recoapp/src/ui/page/user/account_page.dart';
import 'package:recoapp/src/ui/page/user/login_page.dart';
import 'package:recoapp/src/ui/page/user/profile_page.dart';
import 'package:recoapp/src/ui/page/user/register_page.dart';
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

  Diner diner = null;

  String token = null;

  final _dinerRepository = DinerRepository();
  final _reviewRepository = ReviewRepository();
  final _resourceRepository = ResourceRepository();

  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  UserBloc(UserState initialState) : super(initialState);

  @override
  // TODO: implement initialState
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is GetDinerEvent) {
      yield UserLoadingState();
      diner = await _dinerRepository.getDiner(id: event.idUser);
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
        Fluttertoast.showToast(
            msg: "Hãy nhập đầy đủ thông tin!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else {
        List<Object> resultLogin = await _dinerRepository.login(
            username: event.username, password: event.password);

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

        Fluttertoast.showToast(
            msg: "Đăng nhập thành công!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);

        if (diner.fullname == "Chưa cập nhật" &&
            diner.phone == "Chưa cập nhật" &&
            diner.address == "Chưa cập nhật") {
          Navigator.push(
            event.context,
            MaterialPageRoute(builder: (context) => AccountPage()),
          );
        } else {
          Navigator.of(event.context).pop();
        }

        yield UserLoadedState();
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

      print("user google = " + _user.toString());

      List<Object> resultLogin = await _dinerRepository.loginSocial(
          fullname: _user.displayName,
          email: _user.email,
          avatar: _user.photoURL);

      token = resultLogin.elementAt(1).toString();

      Fluttertoast.showToast(
          msg: "Đăng nhập thành công!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 10);

      diner = await _dinerRepository.getDiner(
          id: int.parse(resultLogin.elementAt(0).toString()));
      listFilterItem = await _resourceRepository.getFilterItems();

      areas = diner.activeAreaIds != null ? diner.activeAreaIds.split("&") : [];

      if (diner.tags != null && diner.tags.length > 0) {
        for (int i = 0; i < diner.tags.length; i++) {
          tagId.add(diner.tags[i].id);
        }
      }

      if (diner.fullname == "Chưa cập nhật" ||
          (diner.phone == "Chưa cập nhật" &&
          diner.address == "Chưa cập nhật")) {
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
      } else {
        Navigator.of(event.context).pop();
      }

      yield UserLoadedState();
    }

    if (event is RegisterEvent) {
      yield UserLoadingState();

      if (event.username.trim() == "" ||
          event.password.trim() == "" ||
          event.email.trim() == "") {
        Fluttertoast.showToast(
            msg: "Hãy nhập đầy đủ thông tin!",
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
              msg: "Đăng ký thành công!",
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
        }

        yield UserLoadedState();
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
      print("listReviews " + listReviews.toString());

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
        print("vô");
        areas.add(event.id.toString());
        print("areas = " + areas.toString());
      } else {
        print("vô 3");
        areas.remove(event.id.toString());
        print("areas remove = " + areas.toString());
      }

      yield UserLoadedState();
    }

    if (event is SelectedOtherTagEvent) {
      yield UserLoadingState();

      if (event.value) {
        print("vô 1");
        tagId.add(event.id);
        print("other = " + tagId.toString());
      } else {
        print("vô 2");
        tagId.remove(event.id);
        print("other remove = " + tagId.toString());
      }

      yield UserLoadedState();
    }

    if (event is UpdateProfileEvent) {
      yield UserLoadingState();

      if (areas.length <= 0) {
        Fluttertoast.showToast(
            msg: "Hãy thêm khu vực bạn quan tâm và thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (tagId.length <= 0) {
        Fluttertoast.showToast(
            msg: "Hãy thêm sở thích của bạn và thử lại",
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
              msg: "Cập nhật sở thích thành công",
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

      print("fullname = " + event.fullname);
      print("phone = " + event.phone);
      print("address = " + event.address);
      print("email = " + event.email);
      print("dob = " + event.dob.toString());
      print("gender = " + event.gender.toString());

      if (event.fullname == null ||
          (event.fullname.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "Tên của bạn không được bỏ trống",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.phone == null ||
          (event.phone.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "Số điện thoại của bạn không được bỏ trống",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.email == null ||
          (event.email.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "Email của bạn không được bỏ trống",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 5);
      } else if (event.address == null ||
          (event.address.replaceAll(" ", "")).isEmpty) {
        Fluttertoast.showToast(
            msg: "Địa chỉ của bạn không được bỏ trống",
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
              msg: "Cập nhật thông tin thành công",
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
  }
}