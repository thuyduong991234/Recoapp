import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/rating_bloc/rating_state.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_event.dart';
import 'package:recoapp/src/blocs/user_bloc/reservation_status_bloc/reservation_status_state.dart';
import 'package:recoapp/src/models/reservation.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/user/rating_page.dart';

class ReservationDetail extends StatefulWidget {
  bool isRating;
  bool isReservation;
  bool isCancel;
  int index;
  int typeList;
  Reservation reservation;
  ReservationDetail(
      {this.reservation,
      this.isRating,
      this.isReservation,
      this.isCancel,
      this.index,
      this.typeList});
  @override
  _ReservationDetailState createState() => _ReservationDetailState();
}

class _ReservationDetailState extends State<ReservationDetail> {
  ReservationStatusBloc reservationStatusBloc;

  @override
  void initState() {
    super.initState();
    reservationStatusBloc = context.read<ReservationStatusBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationStatusBloc, ReservationStatusState>(
        bloc: reservationStatusBloc,
        builder: (context, state) {
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
                    Text("TH??NG TIN ?????T CH???",
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
                                    Text("Nh?? h??ng ??p d???ng",
                                        style: TextStyle(
                                            color: kTextDisabledColor,
                                            fontSize: 14.0)),
                                    SizedBox(height: 10),
                                    Text(widget.reservation.detailAddress,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0)),
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
                                  Text("S??? l?????ng",
                                      style: TextStyle(
                                          color: kTextDisabledColor,
                                          fontSize: 14.0)),
                                  SizedBox(height: 10),
                                  Text(
                                      widget.reservation.numberPerson
                                          .toString(),
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
                                  Text("Th???i gian",
                                      style: TextStyle(
                                          color: kTextDisabledColor,
                                          fontSize: 14.0)),
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
                                  Text("??u ????i",
                                      style: TextStyle(
                                          color: kTextDisabledColor,
                                          fontSize: 14.0)),
                                  SizedBox(height: 10),
                                  Text(
                                      widget.reservation.code == null
                                          ? "Tr???ng"
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
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text("Th??ng tin ng?????i ?????t",
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
                                  "H??? v?? t??n",
                                  style: TextStyle(
                                      color: kTextThirdColor, fontSize: 16.0),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "(*)",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
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
                                  "??i???n tho???i li??n h???",
                                  style: TextStyle(
                                      color: kTextThirdColor, fontSize: 16.0),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "(*)",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
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
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text("Th??ng tin th??m",
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
              bottomNavigationBar: (widget.isRating ||
                      widget.isReservation ||
                      widget.isCancel)
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 5),
                      child: FlatButton(
                        onPressed: () {
                          if (widget.isCancel) {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('H???Y Y??U C???U ?????T CH???',
                                    style: TextStyle(
                                        color: kThirdColor, fontSize: 16.0)),
                                content: const Text(
                                    'B???n c?? mu???n h???y y??u c???u ?????t ch??? n??y kh??ng?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('KH??NG',
                                        style: TextStyle(color: kPrimaryColor)),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        reservationStatusBloc.add(
                                            CancelledReservationEvent(
                                                typeList: widget.typeList,
                                                id: widget.reservation.id,
                                                index: widget.index));

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('C??',
                                          style:
                                              TextStyle(color: kPrimaryColor))),
                                ],
                              ),
                            );
                          } else if (widget.isRating) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          child: RatingPage(
                                              idReservation:
                                                  widget.reservation.id,
                                              idRestaurant: widget
                                                  .reservation.idRestaurant),
                                          create: (BuildContext context) =>
                                              RatingBloc(RatingInitial()),
                                        )));
                          }
                        },
                        color: kThirdColor,
                        textColor: Colors.white,
                        child: Text(widget.isRating
                            ? '????NH GI??'
                            : (widget.isReservation ? "?????T CH???" : "H???Y")),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: Text(''),
                    ));
        });
  }
}
