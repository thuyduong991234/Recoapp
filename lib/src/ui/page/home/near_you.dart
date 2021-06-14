import 'dart:async';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/home/checkbox_filter_list.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';
import 'package:recoapp/src/ui/page/search/search.dart';
import 'package:transparent_image/transparent_image.dart';

class NearYouPage extends StatefulWidget {
  @override
  _NearYouPageState createState() => _NearYouPageState();
}

class _NearYouPageState extends State<NearYouPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  FilterBloc filterBloc;
  UserBloc userBloc;

  TextEditingController textMinPrice;
  TextEditingController textMaxPrice;

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  Position currentLocation;

  var titleSortBy = ['Khoảng cách', 'Giá cả', 'Đánh giá'];

  void clearText() {
    filterBloc.add(UnSelectedFilterItemEvent(unSelectedAll: true, index: 0));
    textMinPrice.clear();
    textMaxPrice.clear();
  }

  @override
  void initState() {
    super.initState();
    filterBloc = context.read<FilterBloc>();
    userBloc = context.read<UserBloc>();
    if (filterBloc.minPrice != null)
      textMinPrice = TextEditingController(text: filterBloc.minPrice);
    else
      textMinPrice = TextEditingController();

    if (filterBloc.maxPrice != null)
      textMaxPrice = TextEditingController(text: filterBloc.maxPrice);
    else
      textMaxPrice = TextEditingController();

    //locateLastPosition();
  }

  void locateLastPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position =
        await Geolocator.getLastKnownPosition(forceAndroidLocationManager: true)
            .timeout(Duration(seconds: 60));

    if (position != null) {
      currentLocation = position;
    }
  }

  void locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .timeout(Duration(seconds: 60));

    currentLocation = position;

    print("position " + position.longitude.toString());

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 12);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  showSideSheet({BuildContext context, bool rightSide = true}) {
    showGeneralDialog(
      barrierLabel: "barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Align(
            alignment:
                (rightSide ? Alignment.centerRight : Alignment.centerLeft),
            child: SafeArea(
              child: Container(
                  width: 300,
                  color: kBackgroundColor,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 25,
                                      color: kTextThirdColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                              TextButton(
                                  onPressed: clearText,
                                  child: Text("Xóa hết",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          inherit: false,
                                          color: Colors.red,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold))),
                              TextButton(
                                  onPressed: () {
                                    filterBloc.add(StartFilterEvent());

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: filterBloc,
                                                  child: SearchPage(),
                                                )));
                                  },
                                  child: Text("Xem kết quả",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: kSecondaryColor,
                                          fontSize: 16.0,
                                          inherit: false,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                color: Colors.white,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Text("Sắp xếp theo",
                                            style: TextStyle(
                                                inherit: false,
                                                decoration: TextDecoration.none,
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        height: 5,
                                        width: 50,
                                        color: kPrimaryColor,
                                      ),
                                      Center(
                                        child: GroupButton(
                                          spacing: -1,
                                          isRadio: true,
                                          direction: Axis.horizontal,
                                          onSelected: (index, isSelected) {
                                            filterBloc.add(SelectedSortByEvent(
                                                sortBy: titleSortBy[index]));
                                          },
                                          buttons: titleSortBy,
                                          selectedButtons: [
                                            filterBloc.codeSort
                                          ],
                                          selectedTextStyle: TextStyle(
                                            fontSize: 14,
                                            color: kTextMainColor,
                                          ),
                                          unselectedTextStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          selectedColor: kPrimaryColor,
                                          unselectedColor: Colors.white,
                                          selectedBorderColor: kPrimaryColor,
                                          unselectedBorderColor: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      )
                                    ])),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Khu vực", 0)),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Món ăn", 1)),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Loại hình", 2)),
                            SizedBox(height: 10),
                            Container(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                color: Colors.white,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Text("Mức giá",
                                            style: TextStyle(
                                                inherit: false,
                                                decoration: TextDecoration.none,
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        height: 5,
                                        width: 50,
                                        color: kPrimaryColor,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Material(
                                                color: Colors.transparent,
                                                child: TextField(
                                                  controller: textMinPrice,
                                                  onChanged: (val) {
                                                    filterBloc.add(
                                                        EnterMinPriceEvent(
                                                            minPrice: val));
                                                  },
                                                  inputFormatters: [
                                                    CurrencyTextInputFormatter(
                                                        locale: 'vi',
                                                        decimalDigits: 0,
                                                        symbol: '')
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Từ',
                                                    labelStyle:
                                                        TextStyle(fontSize: 16),
                                                    suffixText: "VND",
                                                  ),
                                                )),
                                            SizedBox(height: 10),
                                            Material(
                                                color: Colors.transparent,
                                                child: TextField(
                                                  controller: textMaxPrice,
                                                  onChanged: (val) {
                                                    filterBloc.add(
                                                        EnterMaxPriceEvent(
                                                            maxPrice: val));
                                                  },
                                                  inputFormatters: [
                                                    CurrencyTextInputFormatter(
                                                        locale: 'vi',
                                                        decimalDigits: 0,
                                                        symbol: '')
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Đến',
                                                    labelStyle:
                                                        TextStyle(fontSize: 16),
                                                    suffixText: "VND",
                                                  ),
                                                )),
                                          ],
                                        ),
                                      )
                                    ])),
                            SizedBox(height: 10),
                            BlocProvider.value(
                                value: filterBloc,
                                child: CheckBoxFilterList("Quốc gia", 4)),
                          ],
                        ),
                      )
                    ],
                  )),
            ));
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset((rightSide ? 1 : -1), 0), end: Offset(0, 0))
                  .animate(animation1),
          child: child,
        );
      },
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controllerGoogleMap.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 16,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      _buildGoogleMap(context),
                      Padding(
                        child: _buildRestaurant(context),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height - 220),
                      ),
                      _buildTopBar(context),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(90)),
            ),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => {Navigator.of(context).pop()},
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: kTextMainColor,
                    size: 20,
                  ),
                )),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(90)),
            ),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () =>
                      {showSideSheet(context: context, rightSide: true)},
                  child:
                      Icon(Icons.filter_list, color: kTextMainColor, size: 20),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(userBloc.latitude, userBloc.longtitude), zoom: 13),
        onMapCreated: (GoogleMapController controller) {
          print("vô map");
          _controllerGoogleMap.complete(controller);
        },
        markers: userBloc.markers,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }

  Widget _buildRestaurant(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          //margin: EdgeInsets.only(top: 10, bottom: 10),
          height: 160.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: userBloc.nearBy.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                  width: 300,
                  child: GestureDetector(
                      onDoubleTap: () {
                        _gotoLocation(userBloc.nearBy[index].latitude,
                            userBloc.nearBy[index].longtitude);
                      },
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (BuildContext context) =>
                                              RestaurantBloc(
                                                  RestaurantInitial())
                                                ..add(GetRestaurantEvent(
                                                    id: userBloc
                                                        .nearBy[index].id)),
                                          child: RestaurantPage(),
                                        )))
                          },
                      child: Container(
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(3, 0),
                            ),
                          ],
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xffededed),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                              child: FadeInImage.memoryNetwork(
                                width: 110,
                                height: 140,
                                placeholder: kTransparentImage,
                                image: userBloc.nearBy[index].carousel !=
                                            null &&
                                        userBloc.nearBy[index].carousel.length >
                                            0
                                    ? userBloc.nearBy[index].carousel[0]
                                    : "https://lauwang.vn/wp-content/uploads/2020/10/LAM03924.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    userBloc.nearBy[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  (userBloc.nearBy[index].starAverage != null &&
                                          userBloc.nearBy[index].starAverage !=
                                              0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                                userBloc.nearBy[index]
                                                                .starAverage >
                                                            0 &&
                                                        userBloc.nearBy[index]
                                                                .starAverage <
                                                            1
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc.nearBy[index]
                                                            .starAverage <=
                                                        0
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.nearBy[index]
                                                                .starAverage >=
                                                            1 &&
                                                        userBloc.nearBy[index]
                                                                .starAverage <
                                                            2
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc.nearBy[index]
                                                            .starAverage <
                                                        1
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.nearBy[index]
                                                                .starAverage >=
                                                            2 &&
                                                        userBloc.nearBy[index]
                                                                .starAverage <
                                                            3
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc.nearBy[index]
                                                            .starAverage <
                                                        2
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.nearBy[index]
                                                                .starAverage >=
                                                            3 &&
                                                        userBloc.nearBy[index]
                                                                .starAverage <
                                                            4
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc.nearBy[index]
                                                            .starAverage <
                                                        3
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            Icon(
                                                userBloc.nearBy[index]
                                                                .starAverage >=
                                                            4 &&
                                                        userBloc.nearBy[index]
                                                                .starAverage <
                                                            5
                                                    ? Icons.star_half
                                                    : Icons.star,
                                                color: userBloc.nearBy[index]
                                                            .starAverage <
                                                        4
                                                    ? kTextDisabledColor
                                                    : Color(0xFFFF8A00),
                                                size: 15.0),
                                            SizedBox(width: 5),
                                            Text("(100)",
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
                                            Text("(100)",
                                                style: TextStyle(
                                                    color: kTextDisabledColor,
                                                    fontSize: 12.0)),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      userBloc.nearBy[index].distance
                                              .toString() +
                                          "km",
                                      style: TextStyle(
                                          color: Color(0xFFFF8A00),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Ưu đãi: -50%",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(userBloc.nearBy[index].detailAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF9A9693),
                                          fontSize: 12.0)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      ((userBloc.nearBy[index].tags
                                                  .map((e) => e.name)
                                                  .toString())
                                              .replaceAll("(", ""))
                                          .replaceAll(")", ""),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.0, color: kThirdColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )));
            },
          ),
        ),
      ],
    );
  }
}
