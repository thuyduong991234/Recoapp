import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/home/campaign_carousel.dart';
import 'package:recoapp/src/ui/page/restaurant/report_page.dart';
import 'package:recoapp/src/ui/page/restaurant/reservation_widget.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';
import 'package:url_launcher/url_launcher.dart';

class VoucherPage extends StatefulWidget {
  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  int currentIndex = 0;
  double top = 0.0;

  RestaurantBloc restaurantBloc;
  UserBloc userBloc;
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
            target: LatLng(restaurantBloc.currentVoucher.latitude,
                restaurantBloc.currentVoucher.longtitude),
            zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          print("v?? map");
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
          if (restaurantBloc.currentVoucher == null)
            return Scaffold(
                body: SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              )),
            ));
          return Scaffold(
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
                                            builder: (context) => ReportPage(
                                                type: 3,
                                                id: restaurantBloc
                                                    .currentVoucher.id)),
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
                            expandedHeight: 280,
                            title: Text(""),
                            floating: false,
                            pinned: true,
                            snap: false,
                            flexibleSpace: LayoutBuilder(builder:
                                (BuildContext context,
                                    BoxConstraints constraints) {
                              top = constraints.biggest.height;
                              return FlexibleSpaceBar(
                                centerTitle: true,
                                title: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Opacity(
                                      opacity: top == 56.0 ? 1.0 : 0.0,
                                      child: Text(
                                        restaurantBloc.currentVoucher.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      )),
                                ),
                                background: Container(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.4),
                                                      BlendMode.darken),
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      restaurantBloc
                                                          .currentVoucher
                                                          .image))),
                                          height: 160,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            FontAwesomeIcons
                                                                .tag,
                                                            color: Colors.red,
                                                            size: 15),
                                                        SizedBox(width: 10),
                                                        Text(
                                                            restaurantBloc
                                                                .currentVoucher
                                                                .code,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                    restaurantBloc
                                                        .currentVoucher.title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18.0)),
                                                SizedBox(height: 10),
                                                (restaurantBloc.currentVoucher
                                                                .starRestaurant !=
                                                            null &&
                                                        restaurantBloc
                                                                .currentVoucher
                                                                .starRestaurant !=
                                                            0)
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Icon(
                                                              restaurantBloc
                                                                          .currentVoucher
                                                                          .starRestaurant >=
                                                                      1
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_half,
                                                              color: Color(
                                                                  0xFFFF8A00),
                                                              size: 15.0),
                                                          Icon(
                                                              restaurantBloc
                                                                          .currentVoucher
                                                                          .starRestaurant >=
                                                                      2
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_half,
                                                              color: Color(
                                                                  0xFFFF8A00),
                                                              size: 15.0),
                                                          Icon(
                                                              restaurantBloc
                                                                          .currentVoucher
                                                                          .starRestaurant >=
                                                                      3
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_half,
                                                              color: Color(
                                                                  0xFFFF8A00),
                                                              size: 15.0),
                                                          Icon(
                                                              restaurantBloc
                                                                          .currentVoucher
                                                                          .starRestaurant >=
                                                                      4
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_half,
                                                              color: Color(
                                                                  0xFFFF8A00),
                                                              size: 15.0),
                                                          Icon(
                                                              restaurantBloc
                                                                          .currentVoucher
                                                                          .starRestaurant >=
                                                                      5
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_half,
                                                              color: Color(
                                                                  0xFFFF8A00),
                                                              size: 15.0),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              "(" +
                                                                  restaurantBloc
                                                                      .currentVoucher
                                                                      .count
                                                                      .toString() +
                                                                  " l?????t ?????t)",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF9A9693),
                                                                  fontSize:
                                                                      14.0))
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Icon(Icons.star,
                                                              color:
                                                                  kTextDisabledColor,
                                                              size: 15.0),
                                                          Icon(Icons.star,
                                                              color:
                                                                  kTextDisabledColor,
                                                              size: 15.0),
                                                          Icon(Icons.star,
                                                              color:
                                                                  kTextDisabledColor,
                                                              size: 15.0),
                                                          Icon(Icons.star,
                                                              color:
                                                                  kTextDisabledColor,
                                                              size: 15.0),
                                                          Icon(Icons.star,
                                                              color:
                                                                  kTextDisabledColor,
                                                              size: 15.0),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              "(" +
                                                                  restaurantBloc
                                                                      .currentVoucher
                                                                      .count
                                                                      .toString() +
                                                                  " l?????t ?????t)",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF9A9693),
                                                                  fontSize:
                                                                      14.0))
                                                        ],
                                                      ),
                                                SizedBox(height: 10),
                                                Text(
                                                    "T??? " + restaurantBloc
                                                        .currentVoucher.fromTime.day.toString() + "/" + restaurantBloc
                                                        .currentVoucher.fromTime.month.toString() + "/" + restaurantBloc
                                                        .currentVoucher.fromTime.year.toString() + " ?????n " + restaurantBloc
                                                        .currentVoucher.toTime.day.toString() + "/" + restaurantBloc
                                                        .currentVoucher.toTime.month.toString() + "/" + restaurantBloc
                                                        .currentVoucher.toTime.year.toString(),
                                                    style: TextStyle(
                                                        color: Color(
                                                                      0xFF9A9693),
                                                        fontSize: 14.0)),
                                              ],
                                            )),
                                      ],
                                    )),
                              );
                            }), // <--- this is required if I want the application bar to show when I scroll up
                          ),
                        ];
                      },
                      body: ListView(scrollDirection: Axis.vertical, children: [
                        SizedBox(height: 20),
                        ReservationWidget(),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Text("??i???u ki???n ??p d???ng",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                height: 3,
                                width: 50,
                                color: kPrimaryColor,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                  '- Ch??? 129K buffet n?????ng (gi?? g???c 139K)\n- ??u ????i ch??a bao g???m VAT\n- ??u ????i ??p d???ng khi ?????t t??? 2 kh??ch tr??? l??n\n- Kh??ng ??p d???ng m?? ch???p m??n h??nh\n- Ph??? thu khi mang ????? u???ng b??n ngo??i v??o theo quy ?????nh c???a h??ng\n\n- Quy ?????nh gi?? buffet tr??? em:\n+ Cao d?????i 1m: Mi???n ph??\n+ T??? 1m - 1m3: T??nh 50% gi?? ???? gi???m c???a ng?????i l???n\n+ Tr??n 1m3: T??nh nh?? ng?????i l???n\n\nTH???I GIAN ??P D???NG\n- Khung gi???: 10h00 - 23h00\n- ??p d???ng t???t c??? c??c ng??y trong tu???n\n- Ch??? ??p d???ng ?????t ch??? kh??ng gi???m gi?? c??c ng??y l???, T???t: 31/12, 1/1, 14/2, 08/3, 10/3 ??m l???ch, 30/4, 1/5, 1/6, 15/8 ??m l???ch, 2/9, 20/10, 20/11, 24-25/12\n\nL??U ??\n- Kh??ng ??p d???ng ?????ng th???i v???i c??c ch????ng tr??nh kh??c\n- Th??ng b??o m?? ngay khi ?????n c???a h??ng ????? ???????c h?????ng d???n nh???n khuy???n m??i\n- Kh??ch h??ng ???????c ph??p ?????n s???m ho???c mu???n h??n 15 ph??t so v???i gi??? h???n ?????n\n- M?? gi???m gi?? kh??ng c?? gi?? tr??? quy ?????i th??nh ti???n m???t\n\nHOTLINE\n- L???u N?????ng Yumei: 034 962 6666\n\nM???O: B???m "Theo d??i" c???a h??ng ????? c???p nh???t nh???ng thay ?????i v??? ??u ????i ngay t???c th??.',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 100,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      wordSpacing: 1)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Text("?????a ch??? nh?? h??ng",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
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
                              Text(restaurantBloc.currentVoucher.address,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black)),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          Text("G???i ??i???n")
                                        ],
                                      )),
                                  SizedBox(width: 30),
                                  FlatButton(
                                      minWidth: 150,
                                      onPressed: () {},
                                      color: kBackgroundColor,
                                      textColor: kThirdColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 15,
                                          ),
                                          SizedBox(width: 10),
                                          Text("Ch??? ???????ng")
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Text("Kh??m ph?? c???a h??ng",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                height: 3,
                                width: 50,
                                color: kPrimaryColor,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Center(
                                  child: Container(
                                      child: Image(
                                        image: NetworkImage(restaurantBloc
                                                    .currentVoucher
                                                    .logoRestaurant !=
                                                null
                                            ? restaurantBloc
                                                .currentVoucher.logoRestaurant
                                            : "https://upload.wikimedia.org/wikipedia/vi/thumb/7/7e/Logo_KFC.svg/1200px-Logo_KFC.svg.png"),
                                        fit: BoxFit.fill,
                                      ),
                                      decoration: BoxDecoration(
                                          //border: Border.all(color: kPrimaryColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white),
                                      width: 100,
                                      height: 100)),
                              SizedBox(height: 10),
                              (restaurantBloc.currentVoucher.starRestaurant !=
                                          null &&
                                      restaurantBloc
                                              .currentVoucher.starRestaurant !=
                                          0)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                            restaurantBloc.currentVoucher
                                                        .starRestaurant >=
                                                    1
                                                ? Icons.star
                                                : Icons.star_half,
                                            color: Color(0xFFFF8A00),
                                            size: 15.0),
                                        Icon(
                                            restaurantBloc.currentVoucher
                                                        .starRestaurant >=
                                                    2
                                                ? Icons.star
                                                : Icons.star_half,
                                            color: Color(0xFFFF8A00),
                                            size: 15.0),
                                        Icon(
                                            restaurantBloc.currentVoucher
                                                        .starRestaurant >=
                                                    3
                                                ? Icons.star
                                                : Icons.star_half,
                                            color: Color(0xFFFF8A00),
                                            size: 15.0),
                                        Icon(
                                            restaurantBloc.currentVoucher
                                                        .starRestaurant >=
                                                    4
                                                ? Icons.star
                                                : Icons.star_half,
                                            color: Color(0xFFFF8A00),
                                            size: 15.0),
                                        Icon(
                                            restaurantBloc.currentVoucher
                                                        .starRestaurant >=
                                                    5
                                                ? Icons.star
                                                : Icons.star_half,
                                            color: Color(0xFFFF8A00),
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
                                            size: 15.0),
                                      ],
                                    ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                    restaurantBloc
                                        .currentVoucher.nameRestaurant,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                    restaurantBloc.currentVoucher.likeRestaurant
                                            .toString() +
                                        " L?????t th??ch - " +
                                        restaurantBloc
                                            .currentVoucher.reservationCount
                                            .toString() +
                                        " L?????t ?????t",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: kTextDisabledColor)),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                    "?????a ch???: " +
                                        restaurantBloc.currentVoucher.address,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.5,
                                        fontSize: 14.0,
                                        color: kTextDisabledColor)),
                              ),
                              Center(
                                  child: TextButton(
                                      onPressed: () {
                                        restaurantBloc.add(GetRestaurantEvent(
                                            idUser: userBloc.diner != null
                                                ? userBloc.diner.id
                                                : null,
                                            longtitude: userBloc.longtitude,
                                            latitude: userBloc.latitude,
                                            id: restaurantBloc
                                                .currentVoucher.idRestaurant));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider.value(
                                                        value: restaurantBloc,
                                                        child:
                                                            RestaurantPage())));
                                      },
                                      child: Text(
                                        "Xem chi ti???t",
                                        style: TextStyle(
                                            fontSize: 14.0, color: kThirdColor),
                                      ))),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          color: kThirdColor.withOpacity(0.2),
                          child: Row(
                            children: [
                              Expanded(
                                child: restaurantBloc.currentVoucher.suitable !=
                                        null
                                    ? Text(
                                        restaurantBloc.currentVoucher.suitable,
                                        style: TextStyle(
                                            height: 1.5,
                                            fontSize: 14.0,
                                            color: Colors.black))
                                    : Container(),
                              ),
                              MaterialButton(
                                onPressed: () {},
                                color: kThirdColor,
                                elevation: 0,
                                child: Text("Th??ch",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 10, bottom: 20),
                            color: Colors.transparent,
                            child: CampaignCarousel()),
                      ]))));
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
