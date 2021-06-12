import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/home/campaign_carousel.dart';
import 'package:recoapp/src/ui/page/restaurant/reservation_widget.dart';
import 'package:recoapp/src/ui/page/restaurant/restaurant_page.dart';

class VoucherPage extends StatefulWidget {
  @override
  _VoucherPageState createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  int currentIndex = 0;
  double top = 0.0;

  RestaurantBloc restaurantBloc;
  UserBloc userBloc;

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
                                                          .carousel[0]))),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                    Text("7 km",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFFF8A00),
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(Icons.star,
                                                        color:
                                                            Color(0xFFFF8A00),
                                                        size: 15.0),
                                                    Icon(Icons.star,
                                                        color:
                                                            Color(0xFFFF8A00),
                                                        size: 15.0),
                                                    Icon(Icons.star,
                                                        color:
                                                            Color(0xFFFF8A00),
                                                        size: 15.0),
                                                    Icon(Icons.star,
                                                        color:
                                                            Color(0xFFFF8A00),
                                                        size: 15.0),
                                                    Icon(Icons.star,
                                                        color:
                                                            Color(0xFFFF8A00),
                                                        size: 15.0),
                                                    SizedBox(width: 5),
                                                    Text("100 - 10 lượt đặt",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF9A9693),
                                                            fontSize: 14.0))
                                                  ],
                                                ),
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
                                child: Text("Điều kiện áp dụng",
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
                                  restaurantBloc.currentVoucher.content != null
                                      ? restaurantBloc.currentVoucher.content
                                      : '- Chỉ 129K buffet nướng (giá gốc 139K)\n- Ưu đãi chưa bao gồm VAT\n- Ưu đãi áp dụng khi đặt từ 2 khách trở lên\n- Không áp dụng mã chụp màn hình\n- Phụ thu khi mang đồ uống bên ngoài vào theo quy định cửa hàng\n\n- Quy định giá buffet trẻ em:\n+ Cao dưới 1m: Miễn phí\n+ Từ 1m - 1m3: Tính 50% giá đã giảm của người lớn\n+ Trên 1m3: Tính như người lớn\n\nTHỜI GIAN ÁP DỤNG\n- Khung giờ: 10h00 - 23h00\n- Áp dụng tất cả các ngày trong tuần\n- Chỉ áp dụng đặt chỗ không giảm giá các ngày lễ, Tết: 31/12, 1/1, 14/2, 08/3, 10/3 âm lịch, 30/4, 1/5, 1/6, 15/8 âm lịch, 2/9, 20/10, 20/11, 24-25/12\n\nLƯU Ý\n- Không áp dụng đồng thời với các chương trình khác\n- Thông báo mã ngay khi đến cửa hàng để được hướng dẫn nhận khuyến mãi\n- Khách hàng được phép đến sớm hoặc muộn hơn 15 phút so với giờ hẹn đến\n- Mã giảm giá không có giá trị quy đổi thành tiền mặt\n\nHOTLINE\n- Lẩu Nướng Yumei: 034 962 6666\n\nMẸO: Bấm "Theo dõi" cửa hàng để cập nhật những thay đổi về ưu đãi ngay tức thì.',
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
                                child: Text("Địa chỉ nhà hàng",
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
                                      onPressed: () {},
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
                                          Text("Chỉ đường")
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
                                child: Text("Khám phá cửa hàng",
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
                                        " Lượt thích - " +
                                        restaurantBloc
                                            .currentVoucher.reservationCount
                                            .toString() +
                                        " Lượt đặt",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: kTextDisabledColor)),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                    "Địa chỉ: " +
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
                                        "Xem chi tiết",
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    restaurantBloc.currentVoucher.cuisine !=
                                            null
                                        ? Text(
                                            restaurantBloc
                                                .currentVoucher.cuisine,
                                            style: TextStyle(
                                                height: 1.5,
                                                fontSize: 16.0,
                                                color: kThirdColor,
                                                fontWeight: FontWeight.bold))
                                        : Container(),
                                    SizedBox(height: 6),
                                    restaurantBloc.currentVoucher.suitable !=
                                            null
                                        ? Text(
                                            restaurantBloc
                                                .currentVoucher.suitable,
                                            style: TextStyle(
                                                height: 1.5,
                                                fontSize: 14.0,
                                                color: Colors.black))
                                        : Container(),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  
                                },
                                color: kThirdColor,
                                elevation: 0,
                                child: Text("Thích",
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
