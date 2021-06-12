import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_state.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_event.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/user/rating_page.dart';
import 'package:recoapp/src/ui/page/user/reservation_detail.dart';
import 'package:recoapp/src/ui/page/user/user_comment_list.dart';

class MyReservationPage extends StatefulWidget {
  @override
  _MyReservationPageState createState() => _MyReservationPageState();
}

class _MyReservationPageState extends State<MyReservationPage>
    with TickerProviderStateMixin {
  ReservationStatusBloc reservationStatusBloc;
  UserBloc userBloc;
  final _scrollControllerTab1 = ScrollController();
  final _scrollControllerTab2 = ScrollController();
  final _scrollControllerTab3 = ScrollController();
  final _scrollControllerTab5 = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollControllerTab1.addListener(_onScrollTab1);
    _scrollControllerTab2.addListener(_onScrollTab2);
    _scrollControllerTab3.addListener(_onScrollTab3);
    _scrollControllerTab5.addListener(_onScrollTab5);
    reservationStatusBloc = context.read<ReservationStatusBloc>();
    userBloc =  context.read<UserBloc>();

    print("userBloc" + userBloc.token);
  }

  @override
  void dispose() {
    _scrollControllerTab1.dispose();
    _scrollControllerTab2.dispose();
    _scrollControllerTab3.dispose();
    _scrollControllerTab5.dispose();
    super.dispose();
  }

  void _onScrollTab1() {
    if (_isBottomTab1)
      context.read<ReservationStatusBloc>().add(GetMoreEvent(idUser: userBloc.diner.id, type: 1));
  }

  void _onScrollTab2() {
    if (_isBottomTab2)
      context.read<ReservationStatusBloc>().add(GetMoreEvent(idUser: userBloc.diner.id, type: 2));
  }

  void _onScrollTab3() {
    if (_isBottomTab3)
      context.read<ReservationStatusBloc>().add(GetMoreEvent(idUser: userBloc.diner.id, type: 3));
  }

  void _onScrollTab5() {
    if (_isBottomTab5)
      context.read<ReservationStatusBloc>().add(GetMoreEvent(idUser: userBloc.diner.id, type: 4));
  }

  bool get _isBottomTab1 {
    print("vo 1");
    if (!_scrollControllerTab1.hasClients) {
      return false;
    }
    final maxScroll = _scrollControllerTab1.position.maxScrollExtent;
    final currentScroll = _scrollControllerTab1.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  bool get _isBottomTab2 {
    print("vo 2");
    if (!_scrollControllerTab2.hasClients) {
      return false;
    }
    final maxScroll = _scrollControllerTab2.position.maxScrollExtent;
    final currentScroll = _scrollControllerTab2.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  bool get _isBottomTab3 {
    print("vo 3");
    if (!_scrollControllerTab3.hasClients) {
      return false;
    }
    final maxScroll = _scrollControllerTab3.position.maxScrollExtent;
    final currentScroll = _scrollControllerTab3.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  bool get _isBottomTab5 {
    print("vo 5");
    if (!_scrollControllerTab5.hasClients) {
      return false;
    }
    final maxScroll = _scrollControllerTab5.position.maxScrollExtent;
    final currentScroll = _scrollControllerTab5.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ReservationStatusBloc, ReservationStatusState>(
        bloc: reservationStatusBloc,
        builder: (context, state) {
          if (state is ReservationStatusInitial)
            return DefaultTabController(
              initialIndex: 0,
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  shadowColor: Colors.transparent,
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: Text(
                    'Đặt chỗ của tôi',
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
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(fontSize: 13),
                    indicatorColor: Colors.white,
                    tabs: <Widget>[
                      Tab(
                        text: "Chờ xác nhận",
                      ),
                      Tab(
                        text: "Đã xác nhận",
                      ),
                      Tab(
                        text: "Lịch sử",
                      ),
                      Tab(
                        text: "Đánh giá",
                      ),
                      Tab(
                        text: "Đã hủy",
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      )),
                    ),
                    Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      )),
                    ),
                    Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      )),
                    ),
                    Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      )),
                    ),
                    Container(
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      )),
                    ),
                  ],
                ),
              ),
            );

          return DefaultTabController(
            initialIndex: 0,
            length: 5,
            child: Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Text(
                  'Đặt chỗ của tôi',
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
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 13),
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      text: "Chờ xác nhận",
                    ),
                    Tab(
                      text: "Đã xác nhận",
                    ),
                    Tab(
                      text: "Lịch sử",
                    ),
                    Tab(
                      text: "Đánh giá",
                    ),
                    Tab(
                      text: "Đã hủy",
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  (state.listWaitApprove != null &&
                          state.listWaitApprove.length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: state.hasReachedMaxWaitApprove
                              ? state.listWaitApprove.length
                              : state.listWaitApprove.length + 1,
                          controller: _scrollControllerTab1,
                          itemBuilder: (BuildContext context, int index) {
                            return index >= state.listWaitApprove.length
                                ? Center(
                                    child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ))
                                : GestureDetector(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReservationDetail(
                                                        reservation: state
                                                                .listWaitApprove[
                                                            index],
                                                        isRating: false,
                                                        isReservation: false,
                                                        isCancel: true,
                                                      )))
                                        },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ưu đãi",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Số lượng",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Thời gian",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        state
                                                                        .listWaitApprove[
                                                                            index]
                                                                        .titleVoucher !=
                                                                    null &&
                                                                !state
                                                                    .listWaitApprove[
                                                                        index]
                                                                    .titleVoucher
                                                                    .isEmpty
                                                            ? state
                                                                .listWaitApprove[
                                                                    index]
                                                                .titleVoucher
                                                            : "Chưa có",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                            height: 1.5,
                                                            color: Color(
                                                                0xFFFF9D7F),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          state
                                                                  .listWaitApprove[
                                                                      index]
                                                                  .numberPerson
                                                                  .toString() +
                                                              " người",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          DateFormat(
                                                                  "dd-MM-yyyy HH:mm")
                                                              .format(state
                                                                  .listWaitApprove[
                                                                      index]
                                                                  .time),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: kTextMainColor,
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  (constraints.constrainWidth() /
                                                                          10)
                                                                      .floor(),
                                                                  (index) =>
                                                                      SizedBox(
                                                                        height:
                                                                            1,
                                                                        width:
                                                                            5,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration:
                                                                              BoxDecoration(color: Colors.grey.shade400),
                                                                        ),
                                                                      )),
                                                          direction:
                                                              Axis.horizontal,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: kTextMainColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.amber.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Icon(
                                                    Icons.restaurant,
                                                    color: kPrimaryColor,
                                                    size: 17,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    width: 200,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            state
                                                                .listWaitApprove[
                                                                    index]
                                                                .nameRestaurant,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .grey)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            state
                                                                .listWaitApprove[
                                                                    index]
                                                                .detailAddress,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF9A9693),
                                                                fontSize:
                                                                    12.0)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    child: TextButton(
                                                        onPressed: () {},
                                                        child: Text("Hủy",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFFECE52)))))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          })
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có yêu cầu đặt chỗ",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ))),
                  (state.listApproved != null && state.listApproved.length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: state.hasReachedMaxApproved
                              ? state.listApproved.length
                              : state.listApproved.length + 1,
                          controller: _scrollControllerTab2,
                          itemBuilder: (BuildContext context, int index) {
                            return index >= state.listApproved.length
                                ? Center(
                                    child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ))
                                : GestureDetector(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReservationDetail(
                                                        reservation:
                                                            state.listApproved[
                                                                index],
                                                        isRating: false,
                                                        isReservation: false,
                                                        isCancel: true,
                                                      )))
                                        },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ưu đãi",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Số lượng",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Thời gian",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        state
                                                                        .listApproved[
                                                                            index]
                                                                        .titleVoucher !=
                                                                    null &&
                                                                !state
                                                                    .listApproved[
                                                                        index]
                                                                    .titleVoucher
                                                                    .isEmpty
                                                            ? state
                                                                .listApproved[
                                                                    index]
                                                                .titleVoucher
                                                            : "Chưa có",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                            height: 1.5,
                                                            color: Color(
                                                                0xFFFF9D7F),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          state
                                                                  .listApproved[
                                                                      index]
                                                                  .numberPerson
                                                                  .toString() +
                                                              " người",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          DateFormat(
                                                                  "dd-MM-yyyy HH:mm")
                                                              .format(state
                                                                  .listApproved[
                                                                      index]
                                                                  .time),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: kTextMainColor,
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  (constraints.constrainWidth() /
                                                                          10)
                                                                      .floor(),
                                                                  (index) =>
                                                                      SizedBox(
                                                                        height:
                                                                            1,
                                                                        width:
                                                                            5,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration:
                                                                              BoxDecoration(color: Colors.grey.shade400),
                                                                        ),
                                                                      )),
                                                          direction:
                                                              Axis.horizontal,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: kTextMainColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.amber.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Icon(
                                                    Icons.restaurant,
                                                    color: kPrimaryColor,
                                                    size: 17,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    width: 200,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            state
                                                                .listApproved[
                                                                    index]
                                                                .nameRestaurant,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .grey)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            state
                                                                .listApproved[
                                                                    index]
                                                                .detailAddress,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF9A9693),
                                                                fontSize:
                                                                    12.0)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    child: TextButton(
                                                        onPressed: () {},
                                                        child: Text("Hủy",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFFECE52)))))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          })
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có yêu cầu đặt chỗ",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ))),
                  (state.listHistory != null && state.listHistory.length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: state.hasReachedMaxHistory
                              ? state.listHistory.length
                              : state.listHistory.length + 1,
                          controller: _scrollControllerTab3,
                          itemBuilder: (BuildContext context, int index) {
                            return index >= state.listHistory.length
                                ? Center(
                                    child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ))
                                : GestureDetector(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReservationDetail(
                                                        reservation: state
                                                            .listHistory[index],
                                                        isRating: true,
                                                        isReservation: false,
                                                        isCancel: false,
                                                      )))
                                        },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ưu đãi",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Số lượng",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Thời gian",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        state.listHistory[index]
                                                                        .titleVoucher !=
                                                                    null &&
                                                                !state
                                                                    .listHistory[
                                                                        index]
                                                                    .titleVoucher
                                                                    .isEmpty
                                                            ? state
                                                                .listHistory[
                                                                    index]
                                                                .titleVoucher
                                                            : "Chưa có",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                            height: 1.5,
                                                            color: Color(
                                                                0xFFFF9D7F),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          state
                                                                  .listHistory[
                                                                      index]
                                                                  .numberPerson
                                                                  .toString() +
                                                              " người",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          DateFormat(
                                                                  "dd-MM-yyyy HH:mm")
                                                              .format(state
                                                                  .listHistory[
                                                                      index]
                                                                  .time),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: kTextMainColor,
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  (constraints.constrainWidth() /
                                                                          10)
                                                                      .floor(),
                                                                  (index) =>
                                                                      SizedBox(
                                                                        height:
                                                                            1,
                                                                        width:
                                                                            5,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration:
                                                                              BoxDecoration(color: Colors.grey.shade400),
                                                                        ),
                                                                      )),
                                                          direction:
                                                              Axis.horizontal,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: kTextMainColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.amber.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Icon(
                                                    Icons.restaurant,
                                                    color: kPrimaryColor,
                                                    size: 17,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    width: 200,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            state
                                                                .listHistory[
                                                                    index]
                                                                .nameRestaurant,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .grey)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            state
                                                                .listHistory[
                                                                    index]
                                                                .detailAddress,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF9A9693),
                                                                fontSize:
                                                                    12.0)),
                                                      ],
                                                    )),
                                                Expanded(
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          BlocProvider(
                                                                            child:
                                                                                RatingPage(idReservation: state.listHistory[index].id, idRestaurant: state.listHistory[index].idRestaurant),
                                                                            create: (BuildContext context) =>
                                                                                RatingBloc(RatingInitial()),
                                                                          )));
                                                        },
                                                        child: Text("Đánh giá",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFFECE52)))))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          })
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có yêu cầu đặt chỗ",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ))),
                  (state.listComments != null && state.listComments.length > 0)
                      ? BlocProvider.value(
                          value: reservationStatusBloc,
                          child: UserCommentList())
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có đánh giá",
                          style:
                              TextStyle(color: kTextThirdColor, fontSize: 14),
                        ))),
                  (state.listCanceled != null && state.listCanceled.length > 0)
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.hasReachedMaxCanceled
                              ? state.listCanceled.length
                              : state.listCanceled.length + 1,
                          controller: _scrollControllerTab5,
                          itemBuilder: (BuildContext context, int index) {
                            return index >= state.listCanceled.length
                                ? Center(
                                    child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ))
                                : GestureDetector(
                                    onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReservationDetail(
                                                        reservation:
                                                            state.listCanceled[
                                                                index],
                                                        isRating: false,
                                                        isReservation: false,
                                                        isCancel: false,
                                                      )))
                                        },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20, top: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ưu đãi",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Số lượng",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Thời gian",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                            fontSize: 14.0)),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        state
                                                                        .listCanceled[
                                                                            index]
                                                                        .titleVoucher !=
                                                                    null &&
                                                                !state
                                                                    .listCanceled[
                                                                        index]
                                                                    .titleVoucher
                                                                    .isEmpty
                                                            ? state
                                                                .listCanceled[
                                                                    index]
                                                                .titleVoucher
                                                            : "Chưa có",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                            height: 1.5,
                                                            color: Color(
                                                                0xFFFF9D7F),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          state
                                                                  .listCanceled[
                                                                      index]
                                                                  .numberPerson
                                                                  .toString() +
                                                              " người",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          DateFormat(
                                                                  "dd-MM-yyyy HH:mm")
                                                              .format(state
                                                                  .listCanceled[
                                                                      index]
                                                                  .time),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF9A9693),
                                                              fontSize: 14.0)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: kTextMainColor,
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: LayoutBuilder(
                                                      builder: (context,
                                                          constraints) {
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  (constraints.constrainWidth() /
                                                                          10)
                                                                      .floor(),
                                                                  (index) =>
                                                                      SizedBox(
                                                                        height:
                                                                            1,
                                                                        width:
                                                                            5,
                                                                        child:
                                                                            DecoratedBox(
                                                                          decoration:
                                                                              BoxDecoration(color: Colors.grey.shade400),
                                                                        ),
                                                                      )),
                                                          direction:
                                                              Axis.horizontal,
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 10,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10)),
                                                        color:
                                                            Color(0xFFF5F5F5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                color: kTextMainColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.amber.shade50,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Icon(
                                                    Icons.restaurant,
                                                    color: kPrimaryColor,
                                                    size: 17,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    width: 200,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            state
                                                                .listCanceled[
                                                                    index]
                                                                .nameRestaurant,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .grey)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            state
                                                                .listCanceled[
                                                                    index]
                                                                .detailAddress,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF9A9693),
                                                                fontSize:
                                                                    12.0)),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          })
                      : Container(
                          child: Center(
                              child: Text(
                          "Chưa có yêu cầu đặt chỗ",
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
