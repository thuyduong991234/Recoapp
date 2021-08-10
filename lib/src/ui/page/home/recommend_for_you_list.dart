import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';

class RecommendForYouList extends StatefulWidget {
  RecommendForYouList();

  @override
  _RecommendForYouListState createState() => _RecommendForYouListState();
}

class _RecommendForYouListState extends State<RecommendForYouList> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  List<Widget> loadPhotos() {
    List<Widget> listWidget = new List<Widget>();

    for (int i = 0; i < userBloc.recomendForYou[0].carousel.length; i++) {
      listWidget.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  fit: BoxFit.cover,
                  image:
                      NetworkImage(userBloc.recomendForYou[0].carousel[i])))));
    }

    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          return userBloc.recomendForYou != null &&
                  userBloc.recomendForYou.length > 0
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Text("Gợi ý cho bạn",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 3,
                    indent: 20,
                    endIndent: 300,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      //First Item
                      Container(
                        margin: EdgeInsets.only(right: 20.0, left: 20.0),
                        child: GestureDetector(
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                                create: (BuildContext
                                                        context) =>
                                                    RestaurantBloc(
                                                        RestaurantInitial())
                                                      ..add(GetRestaurantEvent(
                                                          idUser:
                                                              userBloc.diner !=
                                                                      null
                                                                  ? userBloc
                                                                      .diner.id
                                                                  : null,
                                                          longtitude: userBloc
                                                              .longtitude,
                                                          latitude:
                                                              userBloc.latitude,
                                                          id: userBloc
                                                              .recomendForYou[0]
                                                              .id)),
                                                child: RestaurantPage(),
                                              )))
                                },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Image
                                Container(
                                  height: 180.0,
                                  child: ImageSlideshow(
                                    initialPage: 0,
                                    indicatorColor: kPrimaryColor,
                                    indicatorBackgroundColor: Color(0xFF9A9693),
                                    children:
                                        userBloc.recomendForYou[0].carousel !=
                                                    null &&
                                                userBloc.recomendForYou[0]
                                                        .carousel.length >
                                                    0
                                            ? loadPhotos()
                                            : [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(10)),
                                                  child: Image.network(
                                                    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(10)),
                                                  child: Image.network(
                                                    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(10)),
                                                  child: Image.network(
                                                    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                    autoPlayInterval: 3000,
                                  ),
                                ),
                                //Restaurant name
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(userBloc.recomendForYou[0].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0))),
                                //Vouchet and distance
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                            userBloc.recomendForYou[0]
                                                        .newestVoucher !=
                                                    null
                                                ? "Ưu đãi: " +
                                                    userBloc.recomendForYou[0]
                                                        .newestVoucher
                                                : "",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            userBloc.recomendForYou[0].distance
                                                    .toString() +
                                                " km",
                                            style: TextStyle(
                                                color: Color(0xFFFF8A00),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )),
                                //Rating
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: (userBloc.recomendForYou[0]
                                                  .starAverage !=
                                              null &&
                                          userBloc.recomendForYou[0]
                                                  .starAverage !=
                                              0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                                userBloc.recomendForYou[0]
                                                                .starAverage >
                                                            0 &&
                                                        userBloc
                                                                .recomendForYou[
                                                                    0]
                                                                .starAverage <
                                                            1
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc
                                                            .recomendForYou[0]
                                                            .starAverage <=
                                                        0
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.recomendForYou[0]
                                                                .starAverage >=
                                                            1 &&
                                                        userBloc
                                                                .recomendForYou[
                                                                    0]
                                                                .starAverage <
                                                            2
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc
                                                            .recomendForYou[0]
                                                            .starAverage <
                                                        1
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.recomendForYou[0]
                                                                .starAverage >=
                                                            2 &&
                                                        userBloc
                                                                .recomendForYou[
                                                                    0]
                                                                .starAverage <
                                                            3
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc
                                                            .recomendForYou[0]
                                                            .starAverage <
                                                        2
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.recomendForYou[0]
                                                                .starAverage >=
                                                            3 &&
                                                        userBloc
                                                                .recomendForYou[
                                                                    0]
                                                                .starAverage <
                                                            4
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc
                                                            .recomendForYou[0]
                                                            .starAverage <
                                                        3
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.recomendForYou[0]
                                                                .starAverage >=
                                                            4 &&
                                                        userBloc
                                                                .recomendForYou[
                                                                    0]
                                                                .starAverage <
                                                            5
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc
                                                            .recomendForYou[0]
                                                            .starAverage <
                                                        4
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            SizedBox(width: 5),
                                            Text(
                                                "(" +
                                                    userBloc.recomendForYou[0]
                                                        .commentCount
                                                        .toString() +
                                                    ")",
                                                style: TextStyle(
                                                    color: kTextDisabledColor,
                                                    fontSize: 12.0)),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.star,
                                                color: kTextDisabledColor,
                                                size: 15.0),
                                            Icon(Icons.star,
                                                color: kTextDisabledColor,
                                                size: 15.0),
                                            Icon(Icons.star,
                                                color: kTextDisabledColor,
                                                size: 15.0),
                                            Icon(Icons.star,
                                                color: kTextDisabledColor,
                                                size: 15.0),
                                            Icon(Icons.star,
                                                color: kTextDisabledColor,
                                                size: 15.0),
                                            SizedBox(width: 5),
                                            Text(
                                                "(" +
                                                    userBloc.recomendForYou[0]
                                                        .commentCount
                                                        .toString() +
                                                    ")",
                                                style: TextStyle(
                                                    color: kTextDisabledColor,
                                                    fontSize: 12.0)),
                                          ],
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                      userBloc.recomendForYou[0].detailAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF9A9693),
                                          fontSize: 14.0)),
                                ),
                                //tag
                                userBloc.recomendForYou[0].tags != null &&
                                        userBloc.recomendForYou[0].tags.length >
                                            0
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Wrap(
                                            spacing: 8.0,
                                            children: List<Widget>.generate(
                                                userBloc.recomendForYou[0].tags
                                                            .length >
                                                        1
                                                    ? 2
                                                    : 1, (int index1) {
                                              return Chip(
                                                backgroundColor:
                                                    Color(0xFFFF9D7F),
                                                labelStyle: TextStyle(
                                                    color: kTextMainColor,
                                                    fontSize: 14.0),
                                                label: Text(userBloc
                                                    .recomendForYou[0]
                                                    .tags[index1]
                                                    .name),
                                              );
                                            })))
                                    : Container(),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: userBloc.recomendForYou.length - 1,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (0.7),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: (index + 1) % 2 == 0
                                  ? EdgeInsets.only(right: 10.0, left: 20.0)
                                  : EdgeInsets.only(right: 20.0, left: 10.0),
                              child: GestureDetector(
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (BuildContext context) => RestaurantBloc(
                                                          RestaurantInitial())
                                                        ..add(GetRestaurantEvent(
                                                            idUser:
                                                                userBloc.diner !=
                                                                        null
                                                                    ? userBloc
                                                                        .diner
                                                                        .id
                                                                    : null,
                                                            longtitude: userBloc
                                                                .longtitude,
                                                            latitude: userBloc
                                                                .latitude,
                                                            id: userBloc
                                                                .recomendForYou[
                                                                    index + 1]
                                                                .id)),
                                                      child: RestaurantPage(),
                                                    )))
                                      },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //Image
                                      Container(
                                          height: 110.0,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .carousel !=
                                                                  null &&
                                                              userBloc.recomendForYou[index + 1].carousel.length >
                                                                  0
                                                          ? userBloc
                                                              .recomendForYou[index + 1]
                                                              .carousel[0]
                                                          : 'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg'))))),
                                      //Restaurant name
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                              userBloc.recomendForYou[index + 1]
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0))),
                                      //Vouchet and distance
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  userBloc
                                                              .recomendForYou[
                                                                  index + 1]
                                                              .newestVoucher !=
                                                          null
                                                      ? "Ưu đãi: " +
                                                          userBloc
                                                              .recomendForYou[
                                                                  index + 1]
                                                              .newestVoucher
                                                      : "",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  userBloc
                                                          .recomendForYou[
                                                              index + 1]
                                                          .distance
                                                          .toString() +
                                                      " km",
                                                  style: TextStyle(
                                                      color: Color(0xFFFF8A00),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          )),
                                      //Rating
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: (userBloc
                                                        .recomendForYou[
                                                            index + 1]
                                                        .starAverage !=
                                                    null &&
                                                userBloc
                                                        .recomendForYou[
                                                            index + 1]
                                                        .starAverage !=
                                                    0)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(
                                                      userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage >
                                                                  0 &&
                                                              userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage <
                                                                  1
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: userBloc
                                                                  .recomendForYou[
                                                                      index + 1]
                                                                  .starAverage <=
                                                              0
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage >=
                                                                  1 &&
                                                              userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage <
                                                                  2
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: userBloc
                                                                  .recomendForYou[
                                                                      index + 1]
                                                                  .starAverage <
                                                              1
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage >=
                                                                  2 &&
                                                              userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage <
                                                                  3
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: userBloc
                                                                  .recomendForYou[
                                                                      index + 1]
                                                                  .starAverage <
                                                              2
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage >=
                                                                  3 &&
                                                              userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage <
                                                                  4
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: userBloc
                                                                  .recomendForYou[
                                                                      index + 1]
                                                                  .starAverage <
                                                              3
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage >=
                                                                  4 &&
                                                              userBloc
                                                                      .recomendForYou[
                                                                          index +
                                                                              1]
                                                                      .starAverage <
                                                                  5
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: userBloc
                                                                  .recomendForYou[
                                                                      index + 1]
                                                                  .starAverage <
                                                              4
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      "(" +
                                                          userBloc
                                                              .recomendForYou[
                                                                  index + 1]
                                                              .commentCount
                                                              .toString() +
                                                          ")",
                                                      style: TextStyle(
                                                          color:
                                                              kTextDisabledColor,
                                                          fontSize: 12.0)),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(Icons.star,
                                                      color: kTextDisabledColor,
                                                      size: 15.0),
                                                  Icon(Icons.star,
                                                      color: kTextDisabledColor,
                                                      size: 15.0),
                                                  Icon(Icons.star,
                                                      color: kTextDisabledColor,
                                                      size: 15.0),
                                                  Icon(Icons.star,
                                                      color: kTextDisabledColor,
                                                      size: 15.0),
                                                  Icon(Icons.star,
                                                      color: kTextDisabledColor,
                                                      size: 15.0),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      "(" +
                                                          userBloc
                                                              .recomendForYou[
                                                                  index + 1]
                                                              .commentCount
                                                              .toString() +
                                                          ")",
                                                      style: TextStyle(
                                                          color:
                                                              kTextDisabledColor,
                                                          fontSize: 12.0)),
                                                ],
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            userBloc.recomendForYou[index + 1]
                                                .detailAddress,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Color(0xFF9A9693),
                                                fontSize: 12.0)),
                                      ),
                                      //tag
                                      userBloc.recomendForYou[index + 1].tags !=
                                                  null &&
                                              userBloc.recomendForYou[index + 1]
                                                      .tags.length >
                                                  0
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Wrap(
                                                  spacing: 8.0,
                                                  children:
                                                      List<Widget>.generate(1,
                                                          (int index1) {
                                                    return Chip(
                                                      backgroundColor:
                                                          Color(0xFFFF9D7F),
                                                      labelStyle: TextStyle(
                                                          color: kTextMainColor,
                                                          fontSize: 12.0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                      label: Text(
                                                        userBloc
                                                            .recomendForYou[
                                                                index + 1]
                                                            .tags[index1]
                                                            .name,
                                                      ),
                                                    );
                                                  })))
                                          : Container(),
                                    ],
                                  )),
                            );
                          }),
                    ],
                    //More
                  ),
                  SizedBox(height: 30),
                ])
              : Container();
        });
  }
}
