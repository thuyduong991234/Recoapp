import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/review_bloc/review_bloc.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';
import 'package:recoapp/src/ui/page/review/list_review.dart';
import 'package:recoapp/src/ui/page/review/review_page.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with TickerProviderStateMixin {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          return DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Text(
                  'Yêu thích',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                leading: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: kPrimaryColor,
                      icon: Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                bottom: const TabBar(
                  labelColor: Colors.white,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 16),
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      text: "Nhà hàng",
                    ),
                    Tab(
                      text: "Review",
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  userBloc.diner.favoriteRestaurants != null &&
                          userBloc.diner.favoriteRestaurants.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: userBloc.diner.favoriteRestaurants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    create: (BuildContext
                                                            context) =>
                                                        RestaurantBloc(
                                                            RestaurantInitial())
                                                          ..add(GetRestaurantEvent(
                                                            idUser: userBloc.diner != null ? userBloc.diner.id : null,
                                                            longtitude: userBloc.longtitude,
                                                            latitude: userBloc.latitude,
                                                              id: userBloc
                                                                  .diner
                                                                  .favoriteRestaurants[
                                                                      index]
                                                                  .id)),
                                                    child: RestaurantPage(),
                                                  )))
                                    },
                                child: Container(
                                  height: 70,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        userBloc
                                                    .diner
                                                    .favoriteRestaurants[index]
                                                    .logo !=
                                                null
                                            ? userBloc.diner
                                                .favoriteRestaurants[index].logo
                                            : "https://image.shutterstock.com/image-vector/grill-design-element-vintage-style-260nw-311909807.jpg",
                                        width: 60,
                                        height: 50,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userBloc
                                                  .diner
                                                  .favoriteRestaurants[index]
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              userBloc
                                                  .diner
                                                  .favoriteRestaurants[index]
                                                  .detail,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: kTextThirdColor,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          })
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có lượt thích nào",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ))),
                  userBloc.diner.favoriteReviews != null &&
                          userBloc.diner.favoriteReviews.length > 0
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              itemCount: userBloc.diner.favoriteReviews.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider(
                                                    child: ReviewPage(
                                                        id: userBloc
                                                            .diner
                                                            .favoriteReviews[
                                                                index]
                                                            .id),
                                                    create: (BuildContext
                                                            context) =>
                                                        ReviewBloc(
                                                            ReviewInitial()),
                                                  )));
                                    },
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: userBloc
                                                    .diner
                                                    .favoriteReviews[index]
                                                    .photos[0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 5, top: 10),
                                              child: Text(
                                                  userBloc
                                                      .diner
                                                      .favoriteReviews[index]
                                                      .title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0)),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 5,
                                                          top: 10,
                                                          bottom: 10),
                                                      child: ClipOval(
                                                        child: Image(
                                                          image: CachedNetworkImageProvider(userBloc
                                                                      .diner
                                                                      .favoriteReviews[
                                                                          index]
                                                                      .user
                                                                      .avatar !=
                                                                  null
                                                              ? userBloc
                                                                  .diner
                                                                  .favoriteReviews[
                                                                      index]
                                                                  .user
                                                                  .avatar
                                                              : 'https://www.woolha.com/media/2020/03/eevee.png'),
                                                          width: 20,
                                                          height: 20,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                        userBloc
                                                            .diner
                                                            .favoriteReviews[
                                                                index]
                                                            .user
                                                            .fullname,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color:
                                                                kTextThirdColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.0)),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          userBloc
                                                              .diner
                                                              .favoriteReviews[
                                                                  index]
                                                              .like
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                              color:
                                                                  kTextDisabledColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12.0)),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.favorite,
                                                          color: kThirdColor,
                                                          size: 15),
                                                      SizedBox(width: 5),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )));
                              },
                              staggeredTileBuilder: (index) {
                                return new StaggeredTile.fit(1);
                              }))
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có lượt thích nào",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ))),
                ],
              ),
            ),
          );
        });
  }
}
