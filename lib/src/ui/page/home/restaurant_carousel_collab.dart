import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';

class RestaurantCarouselCollab extends StatefulWidget {
  final String title;

  RestaurantCarouselCollab(this.title);

  @override
  _RestaurantCarouselCollabState createState() => _RestaurantCarouselCollabState();
}

class _RestaurantCarouselCollabState extends State<RestaurantCarouselCollab> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          return userBloc.recommendCollab != null &&
                  userBloc.recommendCollab.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      child: Text(widget.title,
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
                    Container(
                      height: 350.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: userBloc.recommendCollab.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(left: 20.0),
                            width: 300,
                            child: GestureDetector(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (context) => BlocProvider(
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
                                                                  .recommendCollab[
                                                                      index]
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
                                      margin: index ==
                                              userBloc.recommendCollab.length -
                                                  1
                                          ? EdgeInsets.only(right: 20.0)
                                          : EdgeInsets.only(right: 0.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(userBloc
                                                                  .recommendCollab[
                                                                      index]
                                                                  .carousel !=
                                                              null &&
                                                          userBloc
                                                                  .recommendCollab[
                                                                      index]
                                                                  .carousel
                                                                  .length >
                                                              0
                                                      ? userBloc
                                                          .recommendCollab[
                                                              index]
                                                          .carousel[0]
                                                      : "https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg")))),
                                    ),
                                    //Restaurant name
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                            userBloc
                                                .recommendCollab[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0))),
                                    //Vouchet and distance
                                    Padding(
                                        padding: index ==
                                                userBloc.recommendCollab
                                                        .length -
                                                    1
                                            ? EdgeInsets.only(
                                                top: 10, right: 20)
                                            : EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                userBloc.recommendCollab[index]
                                                            .newestVoucher !=
                                                        null
                                                    ? "Ưu đãi: " +
                                                        userBloc
                                                            .recommendCollab[
                                                                index]
                                                            .newestVoucher
                                                    : "",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                userBloc.recommendCollab[index]
                                                        .distance
                                                        .toString() +
                                                    " km",
                                                style: TextStyle(
                                                    color: Color(0xFFFF8A00),
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                    //Rating
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: (userBloc.recommendCollab[index]
                                                      .starAverage !=
                                                  null &&
                                              userBloc.recommendCollab[index]
                                                      .starAverage !=
                                                  0)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                    userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage >
                                                                0 &&
                                                            userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage <
                                                                1
                                                        ? Icons.star_half
                                                        : Icons.star,
                                                    color: userBloc
                                                                .recommendCollab[
                                                                    index]
                                                                .starAverage <=
                                                            0
                                                        ? kTextDisabledColor
                                                        : Color(0xFFFF8A00),
                                                    size: 20.0),
                                                Icon(
                                                    userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage >=
                                                                1 &&
                                                            userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage <
                                                                2
                                                        ? Icons.star_half
                                                        : Icons.star,
                                                    color: userBloc
                                                                .recommendCollab[
                                                                    index]
                                                                .starAverage <
                                                            1
                                                        ? kTextDisabledColor
                                                        : Color(0xFFFF8A00),
                                                    size: 20.0),
                                                Icon(
                                                    userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage >=
                                                                2 &&
                                                            userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage <
                                                                3
                                                        ? Icons.star_half
                                                        : Icons.star,
                                                    color: userBloc
                                                                .recommendCollab[
                                                                    index]
                                                                .starAverage <
                                                            2
                                                        ? kTextDisabledColor
                                                        : Color(0xFFFF8A00),
                                                    size: 20.0),
                                                Icon(
                                                    userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage >=
                                                                3 &&
                                                            userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage <
                                                                4
                                                        ? Icons.star_half
                                                        : Icons.star,
                                                    color: userBloc
                                                                .recommendCollab[
                                                                    index]
                                                                .starAverage <
                                                            3
                                                        ? kTextDisabledColor
                                                        : Color(0xFFFF8A00),
                                                    size: 20.0),
                                                Icon(
                                                    userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage >=
                                                                4 &&
                                                            userBloc
                                                                    .recommendCollab[
                                                                        index]
                                                                    .starAverage <
                                                                5
                                                        ? Icons.star_half
                                                        : Icons.star,
                                                    color: userBloc
                                                                .recommendCollab[
                                                                    index]
                                                                .starAverage <
                                                            4
                                                        ? kTextDisabledColor
                                                        : Color(0xFFFF8A00),
                                                    size: 20.0),
                                                SizedBox(width: 5),
                                                Text(
                                                    "(" +
                                                        userBloc
                                                            .recommendCollab[
                                                                index]
                                                            .commentCount
                                                            .toString() +
                                                        ")",
                                                    style: TextStyle(
                                                        color:
                                                            kTextDisabledColor,
                                                        fontSize: 14.0)),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(Icons.star,
                                                    color: kTextDisabledColor,
                                                    size: 20.0),
                                                Icon(Icons.star,
                                                    color: kTextDisabledColor,
                                                    size: 20.0),
                                                Icon(Icons.star,
                                                    color: kTextDisabledColor,
                                                    size: 20.0),
                                                Icon(Icons.star,
                                                    color: kTextDisabledColor,
                                                    size: 20.0),
                                                Icon(Icons.star,
                                                    color: kTextDisabledColor,
                                                    size: 20.0),
                                                SizedBox(width: 5),
                                                Text(
                                                    "(" +
                                                        userBloc
                                                            .recommendCollab[
                                                                index]
                                                            .commentCount
                                                            .toString() +
                                                        ")",
                                                    style: TextStyle(
                                                        color:
                                                            kTextDisabledColor,
                                                        fontSize: 14.0)),
                                              ],
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                          userBloc.recommendCollab[index]
                                              .detailAddress,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF9A9693),
                                              fontSize: 14.0)),
                                    ),
                                    //tag
                                    userBloc.recommendCollab[index].tags !=
                                                null &&
                                            userBloc.recommendCollab[index].tags
                                                    .length >
                                                0
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Wrap(
                                                spacing: 8.0,
                                                children: List<Widget>.generate(
                                                    userBloc
                                                                .recommendCollab[
                                                                    index]
                                                                .tags
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    label: Text(userBloc
                                                        .recommendCollab[index]
                                                        .tags[index1]
                                                        .name),
                                                  );
                                                })))
                                        : Container(),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                )
              : Container();
        });
  }
}
