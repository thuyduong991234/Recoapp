import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:recoapp/src/models/reservation.dart';
import 'package:recoapp/src/ui/constants.dart';

class ReservationDetail extends StatefulWidget {
  bool isRating;
  bool isReservation;
  bool isCancel;
  Reservation reservation;
  ReservationDetail({this.reservation, this.isRating, this.isReservation, this.isCancel});
  @override
  _ReservationDetailState createState() => _ReservationDetailState();
}

class _ReservationDetailState extends State<ReservationDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          shadowColor: Colors.transparent,
          leading: Material(
              color: Colors.transparent,
              child: IconButton(
                splashColor: kPrimaryColor,
                icon: Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          title: Column(
            children: [
              Text(
                widget.reservation.nameRestaurant,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              SizedBox(height: 5),
              Text("THÔNG TIN ĐẶT CHỖ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FontAwesomeIcons.storeAlt,
                        size: 14.0,
                        color: kTextDisabledColor,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nhà hàng áp dụng",
                                  style: TextStyle(
                                      color: kTextDisabledColor,
                                      fontSize: 14.0)),
                              SizedBox(height: 10),
                              Text(widget.reservation.detailAddress,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0)),
                            ]),
                      )
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 0.5,
                    indent: 30,
                    endIndent: 10,
                    color: kTextDisabledColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.people_outlined,
                        size: 20.0,
                        color: kTextDisabledColor,
                      ),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Số lượng",
                                style: TextStyle(
                                    color: kTextDisabledColor, fontSize: 14.0)),
                            SizedBox(height: 10),
                            Text(widget.reservation.numberPerson.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ])
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 0.5,
                    indent: 30,
                    endIndent: 10,
                    color: kTextDisabledColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FontAwesomeIcons.calendarAlt,
                        size: 15.0,
                        color: kTextDisabledColor,
                      ),
                      SizedBox(width: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Thời gian",
                                style: TextStyle(
                                    color: kTextDisabledColor, fontSize: 14.0)),
                            SizedBox(height: 10),
                            Text(
                                DateFormat('yyyy-MM-dd HH:mm')
                                    .format(widget.reservation.time),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ])
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: 0.5,
                    indent: 30,
                    endIndent: 10,
                    color: kTextDisabledColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FontAwesomeIcons.tag,
                        size: 15.0,
                        color: kTextDisabledColor,
                      ),
                      SizedBox(width: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ưu đãi",
                                style: TextStyle(
                                    color: kTextDisabledColor, fontSize: 14.0)),
                            SizedBox(height: 10),
                            Text(
                                widget.reservation.code == null
                                    ? "Trống"
                                    : widget.reservation.code,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          ])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text("Thông tin người đặt",
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Họ và tên",
                            style: TextStyle(
                                color: kTextThirdColor, fontSize: 16.0),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "(*)",
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                      TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              enabled: false,
                              labelText: widget.reservation.fullname)),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Điện thoại liên hệ",
                            style: TextStyle(
                                color: kTextThirdColor, fontSize: 16.0),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "(*)",
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            enabled: false,
                            labelText: widget.reservation.phoneNumber),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                color: kTextThirdColor, fontSize: 16.0),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "(*)",
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            enabled: false,
                            labelText: widget.reservation.email),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 5),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text("Thông tin thêm",
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
                  Column(
                    children: [
                      TextField(
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        maxLines: 10,
                        maxLength: 1000,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            enabled: false,
                            labelText: widget.reservation.additionalInfo,
                            border: OutlineInputBorder()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )),
        bottomNavigationBar: (widget.isRating || widget.isReservation || widget.isCancel) ? Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          child: FlatButton(
            onPressed: () {
            },
            color: kThirdColor,
            textColor: Colors.white,
            child: Text(widget.isRating ? 'ĐÁNH GIÁ' : (widget.isReservation ? "ĐẶT CHỖ" : "HỦY")),
          ),
        ) : Container(
          color: Colors.white,
          child: Text(''),
         ));
  }
}
