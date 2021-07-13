import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/review_bloc/review_bloc.dart';
import 'package:recoapp/src/blocs/review_bloc/review_event.dart';
import 'package:recoapp/src/blocs/review_bloc/review_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/photo_view.dart';
import 'package:recoapp/src/ui/page/restaurant/report_page.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';

class ReviewPage extends StatefulWidget {
  final int id;
  ReviewPage({this.id});
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  ReviewBloc reviewBloc;
  UserBloc userBloc;
  var listPhotos = [];
  double top = 0.0;

  @override
  void initState() {
    super.initState();

    userBloc = context.read<UserBloc>();
    reviewBloc = context.read<ReviewBloc>()
      ..add(GetDetailReviewEvent(
          id: widget.id,
          idUser: userBloc.diner != null ? userBloc.diner.id : null));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> loadPhotos() {
    List<Widget> listWidget = new List<Widget>();
    for (int i = 0; i < listPhotos.length; i++) {
      listWidget.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: NetworkImage(listPhotos[i])))));
    }

    return listWidget;
  }

  void photoView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewWidget(
          galleryItems: reviewBloc.review.photos,
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
    return BlocBuilder<ReviewBloc, ReviewState>(
        bloc: reviewBloc,
        builder: (context, state) {
          if (reviewBloc.review == null)
            return Scaffold(
                body: SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              )),
            ));
          else {
            listPhotos = reviewBloc.review.photos;
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 200.0,
                  shadowColor: Colors.transparent,
                  automaticallyImplyLeading: true,
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
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(left: 50, bottom: 17),
                        title: Container(
                          margin: EdgeInsets.only(right: 90),
                          child: Opacity(
                            opacity: top <= 86.0 ? 1.0 : 0.0,
                            child: Text(
                              reviewBloc.review.title,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.25),
                            ),
                          ),
                        ),
                        background: Container(
                          color: Colors.white,
                          child: ImageSlideshow(
                            initialPage: 0,
                            indicatorColor: kPrimaryColor,
                            indicatorBackgroundColor: Color(0xFF9A9693),
                            children: loadPhotos(),
                            autoPlayInterval: 3000,
                            height: 160,
                          ),
                        ));
                  }),
                  actions: <Widget>[
                    reviewBloc.isLiked
                        ? Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashColor: kPrimaryColor,
                              icon: Icon(Icons.favorite, color: Colors.white),
                              onPressed: () {
                                reviewBloc.add(UserLikeReviewEvent(
                                    id: reviewBloc.review.id,
                                    isLiked: true,
                                    idUser: userBloc.diner != null
                                        ? userBloc.diner.id
                                        : null));
                              },
                            ))
                        : Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashColor: kPrimaryColor,
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.white),
                              onPressed: () {
                                reviewBloc.add(UserLikeReviewEvent(
                                    id: reviewBloc.review.id,
                                    isLiked: false,
                                    idUser: userBloc.diner != null
                                        ? userBloc.diner.id
                                        : null));
                              },
                            )),
                    Material(
                        color: Colors.transparent,
                        child: IconButton(
                          splashColor: kPrimaryColor,
                          icon: Icon(FontAwesomeIcons.flag,
                              color: Colors.white, size: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportPage(
                                      type: 2,
                                      id: reviewBloc.review.id)),
                            );
                          },
                        )),
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                      child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 20),
                          child: Text(
                            reviewBloc.review.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  reviewBloc.review.user.avatar,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reviewBloc.review.user.fullname,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        reviewBloc.review.createdAt.day
                                                .toString() +
                                            "/" +
                                            reviewBloc.review.createdAt.month
                                                .toString() +
                                            "/" +
                                            reviewBloc.review.createdAt.year
                                                .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextDisabledColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            reviewBloc.review.point.toString(),
                                            style: TextStyle(
                                                color: Color(0xFFFF8A00),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(Icons.star,
                                              color: Color(0xFFFF8A00),
                                              size: 18)
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "(10 lượt xem)",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: kTextDisabledColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            reviewBloc.review.content,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black, fontSize: 14, height: 2),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: reviewBloc.review.tags.length > 0
                              ? Wrap(
                                  spacing: 8.0,
                                  children: List<Widget>.generate(
                                      reviewBloc.review.tags.length,
                                      (int index) {
                                    return index == 0
                                        ? Chip(
                                            label: Text("Tag:"),
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                            backgroundColor: Colors.white,
                                          )
                                        : Chip(
                                            label: Text(reviewBloc
                                                .review.tags[index].name),
                                            labelStyle: TextStyle(
                                                color: Color(0xFFFF8A00),
                                                fontSize: 14.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            backgroundColor: Color(0xffededed),
                                          );
                                  }),
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.favorite,
                                    color: kThirdColor, size: 25),
                                SizedBox(width: 10),
                                Text(
                                  reviewBloc.numberReviewLiked.toString() +
                                      " lượt thích",
                                  style: TextStyle(
                                      color: kThirdColor, fontSize: 14),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.only(left: 13, bottom: 20)),
                        Center(
                            child: Container(
                                child: Image(
                                  image: NetworkImage(reviewBloc
                                              .review.logoRestaurant !=
                                          null
                                      ? reviewBloc.review.logoRestaurant
                                      : "https://upload.wikimedia.org/wikipedia/vi/thumb/7/7e/Logo_KFC.svg/1200px-Logo_KFC.svg.png"),
                                  fit: BoxFit.fill,
                                ),
                                decoration: BoxDecoration(
                                    //border: Border.all(color: kPrimaryColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                width: 100,
                                height: 100)),
                        SizedBox(height: 10),
                        (reviewBloc.review.starRestaurant != null &&
                                reviewBloc.review.starRestaurant != 0)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                      reviewBloc.review.starRestaurant >= 1
                                          ? Icons.star
                                          : Icons.star_half,
                                      color: Color(0xFFFF8A00),
                                      size: 15.0),
                                  Icon(
                                      reviewBloc.review.starRestaurant >= 2
                                          ? Icons.star
                                          : Icons.star_half,
                                      color: Color(0xFFFF8A00),
                                      size: 15.0),
                                  Icon(
                                      reviewBloc.review.starRestaurant >= 3
                                          ? Icons.star
                                          : Icons.star_half,
                                      color: Color(0xFFFF8A00),
                                      size: 15.0),
                                  Icon(
                                      reviewBloc.review.starRestaurant >= 4
                                          ? Icons.star
                                          : Icons.star_half,
                                      color: Color(0xFFFF8A00),
                                      size: 15.0),
                                  Icon(
                                      reviewBloc.review.starRestaurant >= 5
                                          ? Icons.star
                                          : Icons.star_half,
                                      color: Color(0xFFFF8A00),
                                      size: 15.0),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.star,
                                      color: kTextDisabledColor, size: 15.0),
                                  Icon(Icons.star,
                                      color: kTextDisabledColor, size: 15.0),
                                  Icon(Icons.star,
                                      color: kTextDisabledColor, size: 15.0),
                                  Icon(Icons.star,
                                      color: kTextDisabledColor, size: 15.0),
                                  Icon(Icons.star,
                                      color: kTextDisabledColor, size: 15.0),
                                ],
                              ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(reviewBloc.review.nameRestaurant,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                              reviewBloc.review.likeRestaurant.toString() +
                                  " Lượt thích - " +
                                  reviewBloc.numberRestaurantLiked.toString() +
                                  " Lượt đặt",
                              style: TextStyle(
                                  fontSize: 14.0, color: kTextDisabledColor)),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text("Địa chỉ: " + reviewBloc.review.address,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 14.0,
                                  color: kTextDisabledColor)),
                        ),
                        Center(
                            child: TextButton(
                                onPressed: () {
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
                                                          id: reviewBloc.review
                                                              .idRestaurant)),
                                                child: RestaurantPage(),
                                              )));
                                },
                                child: Text(
                                  "Xem chi tiết",
                                  style: TextStyle(
                                      fontSize: 14.0, color: kThirdColor),
                                ))),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          color: kThirdColor.withOpacity(0.2),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    reviewBloc.review.cuisine != null &&
                                            !reviewBloc.review.cuisine.isEmpty
                                        ? Text(reviewBloc.review.cuisine,
                                            style: TextStyle(
                                                height: 1.5,
                                                fontSize: 16.0,
                                                color: kThirdColor,
                                                fontWeight: FontWeight.bold))
                                        : Container(),
                                    SizedBox(height: 6),
                                    reviewBloc.review.suitable != null &&
                                            !reviewBloc.review.suitable.isEmpty
                                        ? Text(reviewBloc.review.suitable,
                                            style: TextStyle(
                                                height: 1.5,
                                                fontSize: 14.0,
                                                color: Colors.black))
                                        : Container(),
                                  ],
                                ),
                              ),
                              reviewBloc.isLikedRestaurant
                                  ? MaterialButton(
                                      onPressed: () {
                                        reviewBloc.add(LikeRestaurantEvent(
                                            id: reviewBloc.review.idRestaurant,
                                            isLiked: true,
                                            idUser: userBloc.diner != null
                                                ? userBloc.diner.id
                                                : null));
                                      },
                                      color: kThirdColor,
                                      elevation: 0,
                                      child: Text("Bỏ Thích",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white)),
                                    )
                                  : MaterialButton(
                                      onPressed: () {
                                        reviewBloc.add(LikeRestaurantEvent(
                                            id: reviewBloc.review.idRestaurant,
                                            isLiked: false,
                                            idUser: userBloc.diner != null
                                                ? userBloc.diner.id
                                                : null));
                                      },
                                      color: kThirdColor,
                                      elevation: 0,
                                      child: Text("Thích",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white)),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          );
        });
  }
}
