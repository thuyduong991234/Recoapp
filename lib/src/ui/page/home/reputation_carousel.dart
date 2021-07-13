import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';

class ReputationCarousel extends StatefulWidget {
  ReputationCarousel();

  @override
  _ReputationCarouselState createState() => _ReputationCarouselState();
}

class _ReputationCarouselState extends State<ReputationCarousel> {
  FilterBloc filterBloc;
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    userBloc = context.read<UserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return filterBloc.top10Restaurant.length > 0
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Text("Địa điểm uy tín",
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
                      height: 280.0,
                      child: GridView.builder(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.85,
                                  mainAxisSpacing: 15.0,
                                  crossAxisSpacing: 15.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (BuildContext context) =>
                                                  RestaurantBloc(
                                                      RestaurantInitial())
                                                    ..add(GetRestaurantEvent(
                                                      idUser: userBloc.diner != null ? userBloc.diner.id : null,
                                                        longtitude:
                                                            userBloc.longtitude,
                                                        latitude:
                                                            userBloc.latitude,
                                                        id: filterBloc
                                                            .top10Restaurant[
                                                                index]
                                                            .id)),
                                              child: RestaurantPage(),
                                            )))
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: kTextMainColor),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Image(
                                          image: NetworkImage(filterBloc
                                                      .top10Restaurant[index]
                                                      .logo !=
                                                  null
                                              ? filterBloc
                                                  .top10Restaurant[index].logo
                                              : "https://upload.wikimedia.org/wikipedia/vi/thumb/7/7e/Logo_KFC.svg/1200px-Logo_KFC.svg.png"),
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 7.0, right: 7.0),
                                          child: Text(
                                              filterBloc
                                                  .top10Restaurant[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13.0))),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 5.0, right: 5.0),
                                        child: (filterBloc
                                                        .top10Restaurant[index]
                                                        .starAverage !=
                                                    null &&
                                                filterBloc
                                                        .top10Restaurant[index]
                                                        .starAverage !=
                                                    0)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                      filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage >
                                                                  0 &&
                                                              filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage <
                                                                  1
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: filterBloc
                                                                  .top10Restaurant[
                                                                      index]
                                                                  .starAverage <=
                                                              0
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage >=
                                                                  1 &&
                                                              filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage <
                                                                  2
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: filterBloc
                                                                  .top10Restaurant[
                                                                      index]
                                                                  .starAverage <
                                                              1
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage >=
                                                                  2 &&
                                                              filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage <
                                                                  3
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: filterBloc
                                                                  .top10Restaurant[
                                                                      index]
                                                                  .starAverage <
                                                              2
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage >=
                                                                  3 &&
                                                              filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage <
                                                                  4
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: filterBloc
                                                                  .top10Restaurant[
                                                                      index]
                                                                  .starAverage <
                                                              3
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                  Icon(
                                                      filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage >=
                                                                  4 &&
                                                              filterBloc
                                                                      .top10Restaurant[
                                                                          index]
                                                                      .starAverage <
                                                                  5
                                                          ? Icons.star_half
                                                          : Icons.star,
                                                      color: filterBloc
                                                                  .top10Restaurant[
                                                                      index]
                                                                  .starAverage <
                                                              4
                                                          ? kTextDisabledColor
                                                          : Color(0xFFFF8A00),
                                                      size: 15.0),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      size: 15.0)
                                                ],
                                              ),
                                      ),
                                    ],
                                  )),
                            );
                          })),
                  SizedBox(height: 30),
                ])
              : Container();
        });
  }
}
