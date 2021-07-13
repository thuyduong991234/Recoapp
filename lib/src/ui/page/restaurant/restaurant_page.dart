import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/home/restaurant_carousel.dart';
import 'package:recoapp/src/ui/page/restaurant/comment_list.dart';
import 'package:recoapp/src/ui/page/restaurant/photo_view.dart';
import 'package:recoapp/src/ui/page/restaurant/report_page.dart';
import 'package:recoapp/src/ui/page/restaurant/reservation_widget.dart';
import 'package:recoapp/src/ui/page/restaurant/vouchers_grid.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  RestaurantBloc restaurantBloc;
  UserBloc userBloc;
  var listPhotos = [
    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg',
    'https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg'
  ];

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  @override
  void initState() {
    super.initState();
    restaurantBloc = context.read<RestaurantBloc>();
    userBloc = context.read<UserBloc>();
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
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: NetworkImage(listPhotos[i])))));
    }

    return listWidget;
  }

  final fieldText = TextEditingController(text: "1");
  int currentIndex = 0;
  double top = 0.0;

  void photoView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewWidget(
          galleryItems: restaurantBloc.data.menu,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget buildRating(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Đánh giá",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Text("(" + restaurantBloc.data.commentCount.toString() + ")",
                      style:
                          TextStyle(fontSize: 14.0, color: kTextDisabledColor)),
                ],
              )),
          Container(
            margin: EdgeInsets.only(right: 10, bottom: 10),
            height: 3,
            width: 50,
            color: kPrimaryColor,
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                      restaurantBloc.data.starAverage == null
                          ? "0"
                          : restaurantBloc.data.starAverage.toStringAsFixed(1),
                      style: TextStyle(color: Colors.black, fontSize: 45)),
                  SizedBox(height: 10),
                  (restaurantBloc.data.starAverage != null &&
                          restaurantBloc.data.starAverage != 0)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                                restaurantBloc.data.starAverage > 0 &&
                                        restaurantBloc.data.starAverage < 1
                                    ? Icons.star_half
                                    : Icons.star,
                                color: restaurantBloc.data.starAverage <= 0
                                    ? kTextDisabledColor
                                    : Color(0xFFFF8A00),
                                size: 20.0),
                            Icon(
                                restaurantBloc.data.starAverage >= 1 &&
                                        restaurantBloc.data.starAverage < 2
                                    ? Icons.star_half
                                    : Icons.star,
                                color: restaurantBloc.data.starAverage < 1
                                    ? kTextDisabledColor
                                    : Color(0xFFFF8A00),
                                size: 20.0),
                            Icon(
                                restaurantBloc.data.starAverage >= 2 &&
                                        restaurantBloc.data.starAverage < 3
                                    ? Icons.star_half
                                    : Icons.star,
                                color: restaurantBloc.data.starAverage < 2
                                    ? kTextDisabledColor
                                    : Color(0xFFFF8A00),
                                size: 20.0),
                            Icon(
                                restaurantBloc.data.starAverage >= 3 &&
                                        restaurantBloc.data.starAverage < 4
                                    ? Icons.star_half
                                    : Icons.star,
                                color: restaurantBloc.data.starAverage < 3
                                    ? kTextDisabledColor
                                    : Color(0xFFFF8A00),
                                size: 20.0),
                            Icon(
                                restaurantBloc.data.starAverage >= 4 &&
                                        restaurantBloc.data.starAverage < 5
                                    ? Icons.star_half
                                    : Icons.star,
                                color: restaurantBloc.data.starAverage < 4
                                    ? kTextDisabledColor
                                    : Color(0xFFFF8A00),
                                size: 20.0),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.star,
                                color: kTextDisabledColor, size: 20.0),
                            Icon(Icons.star,
                                color: kTextDisabledColor, size: 20.0),
                            Icon(Icons.star,
                                color: kTextDisabledColor, size: 20.0),
                            Icon(Icons.star,
                                color: kTextDisabledColor, size: 20.0),
                            Icon(Icons.star,
                                color: kTextDisabledColor, size: 20.0),
                          ],
                        ),
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "5",
                        style: TextStyle(color: kTextThirdColor, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        height: 12,
                        width: restaurantBloc.data.star5 != null &&
                                restaurantBloc.data.commentCount > 0
                            ? (restaurantBloc.data.star5 * 190.0) /
                                restaurantBloc.data.commentCount
                            : 0,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "4",
                        style: TextStyle(color: kTextThirdColor, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        height: 12,
                        width: restaurantBloc.data.star4 != null &&
                                restaurantBloc.data.commentCount > 0
                            ? (restaurantBloc.data.star4 * 190.0) /
                                restaurantBloc.data.commentCount
                            : 0,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "3",
                        style: TextStyle(color: kTextThirdColor, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        height: 12,
                        width: restaurantBloc.data.star3 != null &&
                                restaurantBloc.data.commentCount > 0
                            ? (restaurantBloc.data.star3 * 190.0) /
                                restaurantBloc.data.commentCount
                            : 0,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "2",
                        style: TextStyle(color: kTextThirdColor, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        height: 12,
                        width: restaurantBloc.data.star2 != null &&
                                restaurantBloc.data.commentCount > 0
                            ? (restaurantBloc.data.star2 * 190.0) /
                                restaurantBloc.data.commentCount
                            : 0,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "1",
                        style: TextStyle(color: kTextThirdColor, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        height: 12,
                        width: restaurantBloc.data.star1 != null &&
                                restaurantBloc.data.commentCount > 0
                            ? (restaurantBloc.data.star1 * 190.0) /
                                restaurantBloc.data.commentCount
                            : 0,
                        color: kPrimaryColor,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Đồ ăn",
                      style: TextStyle(color: kTextThirdColor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(
                      (restaurantBloc.data.starFood == null ||
                              restaurantBloc.data.starFood == 0)
                          ? "0"
                          : restaurantBloc.data.starFood.toStringAsFixed(1),
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Dịch vụ",
                      style: TextStyle(color: kTextThirdColor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(
                      (restaurantBloc.data.starService == null ||
                              restaurantBloc.data.starService == 0)
                          ? "0"
                          : restaurantBloc.data.starService.toStringAsFixed(1),
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Không gian",
                      style: TextStyle(color: kTextThirdColor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(
                      (restaurantBloc.data.starAmbiance == null ||
                              restaurantBloc.data.starAmbiance == 0)
                          ? "0"
                          : restaurantBloc.data.starAmbiance.toStringAsFixed(1),
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Độ ồn",
                      style: TextStyle(color: kTextThirdColor, fontSize: 14)),
                  SizedBox(height: 10),
                  Text(
                      (restaurantBloc.data.starNoise == null ||
                              restaurantBloc.data.starNoise == 0)
                          ? "Thấp"
                          : ((restaurantBloc.data.starNoise > 0 &&
                                  restaurantBloc.data.starNoise <= 3)
                              ? "Vừa phải"
                              : "Rất ồn"),
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  double appear(double shrink) => 1 - shrink / 328;

  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(
                restaurantBloc.data.latitude, restaurantBloc.data.longtitude),
            zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          print("vô map");
          _controllerGoogleMap.complete(controller);
        },
        markers: {restaurantBloc.marker},
        zoomControlsEnabled: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,
        builder: (context, state) {
          if (restaurantBloc.data == null)
            return Scaffold(
                body: SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              )),
            ));
          else {
            listPhotos = restaurantBloc.data.carousel;
            restaurantBloc.add(GetRecommendRestaurantEvent(
                latitude: userBloc.latitude, longtitude: userBloc.longtitude));
          }
          return DefaultTabController(
              length: 3,
              child: Scaffold(
                  body: SafeArea(
                      child: NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              new SliverAppBar(
                                actions: <Widget>[
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
                                                builder: (context) =>
                                                    ReportPage(
                                                        type: 1,
                                                        id: restaurantBloc.data.id)),
                                          );
                                        },
                                      )),
                                ],
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
                                expandedHeight: 300,
                                title: Text(""),
                                floating: false,
                                pinned: true,
                                snap: false,
                                flexibleSpace: LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  top = constraints.biggest.height;
                                  return FlexibleSpaceBar(
                                      titlePadding:
                                          EdgeInsets.only(left: 50, right: 50),
                                      centerTitle: false,
                                      title: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Opacity(
                                              opacity: top == 56.0 ? 1.0 : 0.0,
                                              child: Text(
                                                  restaurantBloc.data.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      height: 1.2)))),
                                      background: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          //Image
                                          Container(
                                              height: 300.0,
                                              color: Colors.white,
                                              child: Stack(
                                                children: [
                                                  ImageSlideshow(
                                                    initialPage: 0,
                                                    indicatorColor:
                                                        kPrimaryColor,
                                                    indicatorBackgroundColor:
                                                        Color(0xFF9A9693),
                                                    children: loadPhotos(),
                                                    autoPlayInterval: 3000,
                                                    height: 160,
                                                  ),
                                                  Positioned(
                                                      top: 120,
                                                      left: 10,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  //border: Border.all(color: kPrimaryColor),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(restaurantBloc.data.logo != null &&
                                                                              !restaurantBloc
                                                                                  .data.logo.isEmpty
                                                                          ? restaurantBloc.data.logo.replaceAll(
                                                                              " ",
                                                                              "")
                                                                          : "http://upload.wikimedia.org/wikipedia/vi/thumb/7/7e/Logo_KFC.svg/1200px-Logo_KFC.svg.png"),
                                                                      fit: BoxFit
                                                                          .fitWidth),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(90)),
                                                                  color: Colors.white),
                                                          width: 100,
                                                          height: 100)),
                                                  Positioned(
                                                      top: 210,
                                                      left: 10,
                                                      child: Column(
                                                        children: [
                                                          restaurantBloc
                                                                  .isFollowed
                                                              ? TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        "vô đã thích");
                                                                    restaurantBloc.add(UserLikeRestaurantEvent(
                                                                        longtitude:
                                                                            userBloc
                                                                                .longtitude,
                                                                        latitude:
                                                                            userBloc
                                                                                .latitude,
                                                                        id: restaurantBloc
                                                                            .data
                                                                            .id,
                                                                        isLiked:
                                                                            true,
                                                                        idUser: userBloc.diner !=
                                                                                null
                                                                            ? userBloc.diner.id
                                                                            : null));
                                                                  },
                                                                  child: Container(
                                                                      width: 85.0,
                                                                      padding: EdgeInsets.all(6.0),
                                                                      decoration: BoxDecoration(border: Border.all(color: kThirdColor), borderRadius: BorderRadius.circular(5.0), color: kThirdColor),
                                                                      child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Icon(
                                                                              Icons.favorite,
                                                                              color: Colors.white,
                                                                              size: 18.0),
                                                                          Text(
                                                                              "Đã thích",
                                                                              style: TextStyle(color: Colors.white, fontSize: 13.0))
                                                                        ],
                                                                      )))
                                                              : TextButton(
                                                                  onPressed: () {
                                                                    print(
                                                                        "vô chưa thích");
                                                                    restaurantBloc.add(UserLikeRestaurantEvent(
                                                                        longtitude:
                                                                            userBloc
                                                                                .longtitude,
                                                                        latitude:
                                                                            userBloc
                                                                                .latitude,
                                                                        id: restaurantBloc
                                                                            .data
                                                                            .id,
                                                                        isLiked:
                                                                            false,
                                                                        idUser: userBloc.diner !=
                                                                                null
                                                                            ? userBloc.diner.id
                                                                            : null));
                                                                  },
                                                                  child: Container(
                                                                      width: 85.0,
                                                                      padding: EdgeInsets.all(6.0),
                                                                      decoration: BoxDecoration(border: Border.all(color: kThirdColor), borderRadius: BorderRadius.circular(5.0), color: Colors.white),
                                                                      child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Icon(
                                                                              Icons.favorite,
                                                                              color: kThirdColor,
                                                                              size: 18.0),
                                                                          Text(
                                                                              "Thích",
                                                                              style: TextStyle(color: kThirdColor, fontSize: 13.0))
                                                                        ],
                                                                      ))),
                                                          Text(
                                                              "(" +
                                                                  restaurantBloc
                                                                      .numberLiked
                                                                      .toString() +
                                                                  " Lượt thích)",
                                                              style: TextStyle(
                                                                  color:
                                                                      kTextDisabledColor,
                                                                  fontSize:
                                                                      12.0))
                                                        ],
                                                      )),
                                                  Positioned(
                                                      top: 165,
                                                      left: 120,
                                                      child: Container(
                                                          width: 270,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  restaurantBloc
                                                                      .data
                                                                      .name,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  softWrap:
                                                                      true,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          18.0)),
                                                              SizedBox(
                                                                  height: 5),
                                                              (restaurantBloc.data
                                                                              .starAverage !=
                                                                          null &&
                                                                      restaurantBloc
                                                                              .data
                                                                              .starAverage !=
                                                                          0)
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                            restaurantBloc.data.starAverage >= 1
                                                                                ? Icons.star
                                                                                : Icons.star_half,
                                                                            color: Color(0xFFFF8A00),
                                                                            size: 20.0),
                                                                        Icon(
                                                                            restaurantBloc.data.starAverage >= 2
                                                                                ? Icons.star
                                                                                : Icons.star_half,
                                                                            color: Color(0xFFFF8A00),
                                                                            size: 20.0),
                                                                        Icon(
                                                                            restaurantBloc.data.starAverage >= 3
                                                                                ? Icons.star
                                                                                : Icons.star_half,
                                                                            color: Color(0xFFFF8A00),
                                                                            size: 20.0),
                                                                        Icon(
                                                                            restaurantBloc.data.starAverage >= 4
                                                                                ? Icons.star
                                                                                : Icons.star_half,
                                                                            color: Color(0xFFFF8A00),
                                                                            size: 20.0),
                                                                        Icon(
                                                                            restaurantBloc.data.starAverage >= 5
                                                                                ? Icons.star
                                                                                : Icons.star_half,
                                                                            color: Color(0xFFFF8A00),
                                                                            size: 20.0),
                                                                        SizedBox(
                                                                            width:
                                                                                5),
                                                                        Text(
                                                                            "(" +
                                                                                restaurantBloc.data.commentCount.toString() +
                                                                                ") " +
                                                                                " - " +
                                                                                restaurantBloc.data.reservationCount.toString() +
                                                                                " lượt đặt",
                                                                            style: TextStyle(color: kTextThirdColor, fontSize: 14.0))
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                kTextDisabledColor,
                                                                            size:
                                                                                20.0),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                kTextDisabledColor,
                                                                            size:
                                                                                20.0),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                kTextDisabledColor,
                                                                            size:
                                                                                20.0),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                kTextDisabledColor,
                                                                            size:
                                                                                20.0),
                                                                        Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                kTextDisabledColor,
                                                                            size:
                                                                                20.0),
                                                                        SizedBox(
                                                                            width:
                                                                                5),
                                                                        Text(
                                                                            restaurantBloc.data.commentCount.toString() +
                                                                                " - " +
                                                                                restaurantBloc.data.reservationCount.toString() +
                                                                                " lượt đặt",
                                                                            style: TextStyle(color: kTextThirdColor, fontSize: 14.0))
                                                                      ],
                                                                    ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          "Đang mở",
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 14.0,
                                                                              fontWeight: FontWeight.bold)),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text("-",
                                                                          style: TextStyle(
                                                                              color: kTextThirdColor,
                                                                              fontSize: 14.0)),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                          "Đóng 23:00",
                                                                          style: TextStyle(
                                                                              color: kTextThirdColor,
                                                                              fontSize: 14.0)),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                      restaurantBloc
                                                                              .data
                                                                              .distance
                                                                              .toString() +
                                                                          " km",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFFFF8A00),
                                                                          fontSize:
                                                                              14.0,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text("Giá:",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextThirdColor,
                                                                          fontSize:
                                                                              14.0)),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                      restaurantBloc
                                                                          .data
                                                                          .minPrice
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextThirdColor,
                                                                          fontSize:
                                                                              14.0)),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text("-",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextThirdColor,
                                                                          fontSize:
                                                                              14.0)),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                      restaurantBloc
                                                                          .data
                                                                          .maxPrice
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextThirdColor,
                                                                          fontSize:
                                                                              14.0)),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                      "VND/người",
                                                                      style: TextStyle(
                                                                          color:
                                                                              kTextThirdColor,
                                                                          fontSize:
                                                                              14.0)),
                                                                ],
                                                              ),
                                                            ],
                                                          ))),
                                                ],
                                              )),
                                        ],
                                      ));
                                }), // <--- this is required if I want the application bar to show when I scroll up
                              ),
                              SliverPersistentHeader(
                                  pinned: true,
                                  delegate: _SliverAppBarDelegate(
                                    TabBar(
                                      isScrollable: false,
                                      indicatorColor: kPrimaryColor,
                                      labelColor: kPrimaryColor,
                                      unselectedLabelColor: Colors.black,
                                      labelPadding: EdgeInsets.all(0),
                                      labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                      unselectedLabelStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal),
                                      tabs: [
                                        Tab(
                                          text: "Đặt chỗ",
                                        ),
                                        Tab(
                                          text: "Menu & Ưu đãi",
                                        ),
                                        Tab(
                                          text: "Đánh giá",
                                        ),
                                      ],
                                    ),
                                  ))
                            ];
                          },
                          body: new TabBarView(children: [
                            ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                BlocProvider.value(
                                    value: restaurantBloc,
                                    child: ReservationWidget()),
                                Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 19),
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: restaurantBloc.data.tags != null &&
                                            restaurantBloc.data.tags.length > 0
                                        ? Wrap(
                                            spacing: 8.0,
                                            children: List<Widget>.generate(
                                                restaurantBloc
                                                        .data.tags.length +
                                                    1, (int index) {
                                              return index == 0
                                                  ? Chip(
                                                      label: Text("Tag:"),
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      backgroundColor:
                                                          Colors.white,
                                                    )
                                                  : ChoiceChip(
                                                      backgroundColor:
                                                          Color(0xFFFF8A00)
                                                              .withOpacity(0.3),
                                                      selected: false,
                                                      onSelected:
                                                          (isSelected) {},
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xFFFF8A00),
                                                          fontSize: 14.0),
                                                      label: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(restaurantBloc
                                                              .data
                                                              .tags[index - 1]
                                                              .name),
                                                        ],
                                                      ),
                                                    );
                                            }),
                                          )
                                        : Container()),
                                SizedBox(height: 20),
                                BlocProvider.value(
                                    value: restaurantBloc,
                                    child: buildRating(context)),
                                SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        child: Text("Thông tin nhà hàng",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        height: 3,
                                        width: 50,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      _buildGoogleMap(context),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(restaurantBloc.data.detailAddress,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black)),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FlatButton(
                                              minWidth: 150,
                                              onPressed: () {
                                                launch("tel://0989622590");
                                              },
                                              color: kBackgroundColor,
                                              textColor: kThirdColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.phoneAlt,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text("Gọi điện")
                                                ],
                                              )),
                                          SizedBox(width: 30),
                                          FlatButton(
                                              minWidth: 150,
                                              onPressed: () {
                                                _launchMapsUrl(
                                                    restaurantBloc
                                                        .data.latitude,
                                                    restaurantBloc
                                                        .data.longtitude);
                                              },
                                              color: kBackgroundColor,
                                              textColor: kThirdColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .locationArrow,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text("Chỉ đường")
                                                ],
                                              )),
                                        ],
                                      ),
                                      Divider(
                                        height: 10,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(FontAwesomeIcons.phoneAlt,
                                                size: 15, color: kPrimaryColor),
                                            SizedBox(width: 15),
                                            Text("Điện thoại",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            SizedBox(width: 10),
                                            Text("098 9622 590",
                                                style: TextStyle(
                                                    color: kThirdColor,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(FontAwesomeIcons.dollarSign,
                                                size: 15, color: kPrimaryColor),
                                            SizedBox(width: 15),
                                            Text("Giá cả",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            SizedBox(width: 10),
                                            Text(
                                                restaurantBloc.data.minPrice
                                                        .toString() +
                                                    " - " +
                                                    restaurantBloc.data.maxPrice
                                                        .toString() +
                                                    " VND",
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: kTextThirdColor,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.restaurant_rounded,
                                                size: 20, color: kPrimaryColor),
                                            SizedBox(width: 11),
                                            Text("Ẩm thực",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                  (restaurantBloc.data.cuisine
                                                          .replaceAll(
                                                              ".", ".\n"))
                                                      .replaceAll(" -", "\n-"),
                                                  maxLines: null,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      height: 1.2,
                                                      color: kTextThirdColor,
                                                      fontSize: 14)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.military_tech_outlined,
                                                size: 20, color: kPrimaryColor),
                                            SizedBox(width: 11),
                                            Text("Phù hợp",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                  restaurantBloc.data.suitable,
                                                  maxLines: null,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      height: 1.2,
                                                      color: kTextThirdColor,
                                                      fontSize: 14)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 3),
                                                  Icon(FontAwesomeIcons.clock,
                                                      size: 15,
                                                      color: kPrimaryColor),
                                                  SizedBox(width: 12),
                                                  Text("Giờ hoạt động",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 30),
                                                  Expanded(
                                                    child: Text(
                                                        restaurantBloc
                                                            .data.openTime,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 10,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            color:
                                                                kTextThirdColor,
                                                            fontSize: 14)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                      FontAwesomeIcons
                                                          .moneyCheckAlt,
                                                      size: 15,
                                                      color: kPrimaryColor),
                                                  SizedBox(width: 15),
                                                  Text("Hình thức thanh toán",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 30),
                                                  Expanded(
                                                    child: Text(
                                                        restaurantBloc
                                                            .data.payment
                                                            .replaceAll(
                                                                "&", " & "),
                                                        textAlign:
                                                            TextAlign.justify,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color:
                                                                kTextThirdColor,
                                                            fontSize: 14)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 3),
                                                  Icon(FontAwesomeIcons.carAlt,
                                                      size: 17,
                                                      color: kPrimaryColor),
                                                  SizedBox(width: 10),
                                                  Text("Bãi đậu xe",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 30),
                                                  Expanded(
                                                    child: Text(
                                                        (restaurantBloc
                                                                .data.parking
                                                                .replaceAll(
                                                                    ") -",
                                                                    "\n-"))
                                                            .replaceAll(
                                                                " -", "\n-"),
                                                        maxLines: null,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            height: 1.2,
                                                            color:
                                                                kTextThirdColor,
                                                            fontSize: 14)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 3),
                                                  Icon(FontAwesomeIcons.store,
                                                      size: 15,
                                                      color: kPrimaryColor),
                                                  SizedBox(width: 12),
                                                  Text("Không gian",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 30),
                                                  Expanded(
                                                    child: Text(
                                                        restaurantBloc
                                                            .data.space
                                                            .replaceAll(
                                                                " - ", "\n- "),
                                                        maxLines: null,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            height: 1.2,
                                                            color:
                                                                kTextThirdColor,
                                                            fontSize: 14)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 2),
                                                  Icon(
                                                      FontAwesomeIcons
                                                          .nutritionix,
                                                      size: 20,
                                                      color: kPrimaryColor),
                                                  SizedBox(width: 10),
                                                  Text("Giới thiệu",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 30),
                                                  Expanded(
                                                    child: Text(
                                                        restaurantBloc
                                                            .data.introduction,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        maxLines: null,
                                                        style: TextStyle(
                                                            height: 1.2,
                                                            color:
                                                                kTextThirdColor,
                                                            fontSize: 14)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 20),
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RestaurantCarousel("Có thể bạn quan tâm",
                                          restaurantBloc.recommendRestaurant)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ListView(
                              children: [
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 20),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                      left: 10),
                                                  child: Text("Menu",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, left: 10),
                                                  height: 3,
                                                  width: 70,
                                                  color: kPrimaryColor,
                                                ),
                                              ]),
                                          restaurantBloc.data.menu != null &&
                                                  restaurantBloc
                                                          .data.menu.length >
                                                      0
                                              ? TextButton(
                                                  style: ButtonStyle(),
                                                  onPressed: () {
                                                    photoView(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text("Xem tất cả",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              inherit: false,
                                                              color:
                                                                  kThirdColor,
                                                              fontSize: 14.0)),
                                                      SizedBox(width: 5),
                                                      Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          color: kThirdColor,
                                                          size: 14)
                                                    ],
                                                  ))
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      restaurantBloc.data.menu != null &&
                                              restaurantBloc.data.menu.length >
                                                  0
                                          ? Expanded(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return restaurantBloc.data
                                                                .menu.length >
                                                            index
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              photoView(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              width: 85,
                                                              margin: index != 3
                                                                  ? EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10)
                                                                  : EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              0),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5)),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: NetworkImage(restaurantBloc
                                                                          .data
                                                                          .menu[index]))),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            )
                                          : Expanded(
                                              child: Center(
                                                  child: Text(
                                                      "Chưa có thông tin",
                                                      style: TextStyle(
                                                          color:
                                                              kTextThirdColor,
                                                          fontSize: 14.0)))),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 20),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 5,
                                                      left: 10),
                                                  child: Text("Ưu đãi",
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10, left: 10),
                                                  height: 3,
                                                  width: 70,
                                                  color: kPrimaryColor,
                                                ),
                                              ]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      BlocProvider.value(
                                          value: restaurantBloc,
                                          child: VouchersGrid()),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 20),
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RestaurantCarousel("Có thể bạn quan tâm",
                                          restaurantBloc.recommendRestaurant)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                color: Colors.white,
                                child: ListView(
                                  children: [
                                    BlocProvider.value(
                                        value: restaurantBloc,
                                        child: buildRating(context)),
                                    (restaurantBloc.listComment == null ||
                                            restaurantBloc.listComment.length <=
                                                0)
                                        ? Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(
                                                "Chưa có đánh giá",
                                                style: TextStyle(
                                                    color: kTextThirdColor,
                                                    fontSize: 14),
                                              ),
                                            ))
                                        : BlocProvider.value(
                                            value: restaurantBloc,
                                            child: CommentList()),
                                  ],
                                ))
                          ] // <--- the array item is a ListView
                              )))));
        });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: tagChip.withOpacity(0.5),
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
