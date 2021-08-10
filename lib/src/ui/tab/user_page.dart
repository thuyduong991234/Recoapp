import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_event.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/photo_view.dart';
import 'package:recoapp/src/ui/page/user/account_page.dart';
import 'package:recoapp/src/ui/page/user/change_password_page.dart';
import 'package:recoapp/src/ui/page/user/favorite_page.dart';
import 'package:recoapp/src/ui/page/user/login_page.dart';
import 'package:recoapp/src/ui/page/user/my_reservation_page.dart';
import 'package:recoapp/src/ui/page/user/my_review.dart';
import 'package:recoapp/src/ui/page/user/profile_page.dart';
import 'package:recoapp/src/ui/page/user/register_page.dart';
import 'package:recoapp/src/ui/page/user/setting_page.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var listPhotos = [
    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg'
  ];

  UserBloc userBloc;
  FilterBloc filterBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    print("vô user page");
    if (userBloc.diner != null) {
      userBloc.add(GetDinerEvent(idUser: userBloc.diner.id));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void photoView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewWidget(
          galleryItems: [
            "https://bizweb.dktcdn.net/100/326/076/products/vector-illustration-menu-with-special-offer-various-herbs-spices-seasonings-condiments-1441-521.jpg?v=1550890968890",
            'https://bizweb.dktcdn.net/100/326/076/products/vector-illustration-menu-with-special-offer-various-herbs-spices-seasonings-condiments-1441-521.jpg?v=1550890968890',
            'https://bizweb.dktcdn.net/100/326/076/products/vector-illustration-menu-with-special-offer-various-herbs-spices-seasonings-condiments-1441-521.jpg?v=1550890968890',
            'https://bizweb.dktcdn.net/100/326/076/products/vector-illustration-menu-with-special-offer-various-herbs-spices-seasonings-condiments-1441-521.jpg?v=1550890968890'
          ],
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          if (userBloc.diner == null)
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 13),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingPage(),
                                      ));
                                },
                                icon: Icon(FontAwesomeIcons.cog),
                                color: Colors.black54,
                                iconSize: 20,
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0001),
                    Center(
                      child: Text(
                        "WELCOME TO RECO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: kSecondaryColor),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 15),
                      child: Image.asset(
                        'assets/image3.PNG',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextButton(
                        child: Padding(
                          child: Text("ĐĂNG NHẬP".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(10)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: kPrimaryColor)))),
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                            value: userBloc,
                                            child: LoginPage(),
                                          )))
                            }),
                    TextButton(
                        child: Padding(
                          child: Text("ĐĂNG KÝ".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 90, vertical: 5),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(10)),
                            //backgroundColor: MaterialStateProperty.all<Color>(kBackgroundColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: kPrimaryColor)))),
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                            value: userBloc,
                                            child: RegisterPage(),
                                          )))
                            }),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            );
          else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: ListView(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 13),
                                onPressed: () {
                                  userBloc.add(LogoutEvent(context: context));
                                },
                                icon: Icon(FontAwesomeIcons.signOutAlt),
                                color: Colors.black54,
                                iconSize: 20,
                              ),
                            )
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    userBloc.diner != null
                                        ? userBloc.diner.avatar
                                            .replaceAll(" ", "")
                                        : "https://material-kit-react.devias.io/static/images/avatars/avatar_6.png",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userBloc.diner.fullname,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Điểm tích lũy: " +
                                            userBloc.diner.point.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextDisabledColor,
                                            fontSize: 16),
                                      ),
                                      
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Review",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: kSecondaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                userBloc.diner.reviewCount
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 50),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Đặt chỗ",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: kSecondaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                userBloc.diner.reservationCount
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 50),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Level",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: kSecondaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                userBloc.diner.level
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: userBloc,
                                                    child: AccountPage(),
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.user,
                                            color: kSecondaryColor, size: 23),
                                        SizedBox(height: 10),
                                        Text(
                                          "Tài khoản",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      userBloc.add(GetUserReviewsEvent());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: userBloc,
                                                    child: MyReviewPage(),
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.handPeace,
                                            color: kSecondaryColor, size: 23),
                                        SizedBox(height: 10),
                                        Text(
                                          "Review",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: userBloc,
                                                    child: FavoritePage(),
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.heart,
                                            color: kSecondaryColor, size: 23),
                                        SizedBox(height: 10),
                                        Text(
                                          "Yêu thích",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SettingPage(),
                                          ));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.cog,
                                            color: kSecondaryColor, size: 23),
                                        SizedBox(height: 10),
                                        Text(
                                          "Cài đặt",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    child: MyReservationPage(),
                                                    create: (BuildContext
                                                            context) =>
                                                        ReservationStatusBloc(
                                                            ReservationStatusInitial())
                                                          ..add(
                                                              GetReservationEvent(
                                                                  idUser:
                                                                      userBloc
                                                                          .diner
                                                                          .id)),
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.conciergeBell,
                                            color: kSecondaryColor, size: 23),
                                        SizedBox(height: 10),
                                        Text(
                                          "Đặt bàn",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )),
                                SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: userBloc,
                                                    child: ChangePasswordPage(),
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(FontAwesomeIcons.lock,
                                            color: kSecondaryColor, size: 23),
                                        SizedBox(height: 10),
                                        Text(
                                          "Đổi mật khẩu",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 30, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sở thích",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 13),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                                value: userBloc,
                                                child: ProfilePage(),
                                              )));
                                },
                                icon: Icon(FontAwesomeIcons.edit),
                                color: Colors.black54,
                                iconSize: 20,
                              ),
                            )
                          ],
                        )),
                    userBloc.diner != null && userBloc.diner.tags.length > 0
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 5.0,
                              children: List<Widget>.generate(
                                  userBloc.diner.tags.length, (int index) {
                                return Chip(
                                  label: Text(userBloc.diner.tags[index].name),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFFF8A00), fontSize: 14.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor: Color(0xffededed),
                                );
                              }),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }
        });
  }
}
