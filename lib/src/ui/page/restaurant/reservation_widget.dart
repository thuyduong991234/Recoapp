import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_event.dart';
import 'package:recoapp/src/blocs/restaurant_bloc/restaurant_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/restaurant/reservation_confirm.dart';

class ReservationWidget extends StatefulWidget {
  @override
  _ReservationWidgetState createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  RestaurantBloc restaurantBloc;
  UserBloc userBloc;
  var time = [];
  int _currentValue = 1;
  final fieldText = TextEditingController(text: "1");
  DateTime now;
  var listTime;

  @override
  void initState() {
    super.initState();
    restaurantBloc = context.read<RestaurantBloc>();
    userBloc = context.read<UserBloc>();
    now = DateTime.now();
    renderTime(now);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void renderTime(DateTime selectedTime) {
    listTime = [];
    var hour = 0;
    var minute = 0;

    if (selectedTime.year == now.year &&
        selectedTime.month == now.month &&
        selectedTime.day == now.day) selectedTime = now;

    hour = selectedTime.hour < 7 ? 7 : selectedTime.hour;

    if (selectedTime.minute == 0) {
      minute = 0;
    } else if (selectedTime.minute > 0 && selectedTime.minute <= 15) {
      minute = 15;
    } else if (selectedTime.minute > 15 && selectedTime.minute <= 30) {
      minute = 30;
    } else if (selectedTime.minute > 30 && selectedTime.minute <= 45) {
      minute = 45;
    } else if (selectedTime.minute > 45) {
      minute = 0;
      hour = selectedTime.hour + 1;
    }

    DateTime time = new DateTime(
        selectedTime.year, selectedTime.month, selectedTime.day, hour, minute);
    var listTime1 = [];

    while (time.hour < 23) {
      listTime1.add(time);

      time = time.add(Duration(minutes: 15));
    }

    listTime1.add(time);
    //print(":" + listTime1[listTime1.length - 1].toString());
    setState(() {
      listTime = listTime1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
        bloc: restaurantBloc,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ngày",
                                        style:
                                            TextStyle(color: kTextThirdColor),
                                      ),
                                      SizedBox(height: 10),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            primaryColor: kPrimaryColor,
                                            colorScheme:
                                                ColorScheme.light().copyWith(
                                              primary: kPrimaryColor,
                                            ),
                                          ),
                                          child: DateTimePicker(
                                            calendarTitle: "CHỌN NGÀY",
                                            cursorColor: kPrimaryColor,
                                            style: TextStyle(fontSize: 14.0),
                                            initialValue:
                                                DateTime.now().toString(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                            timeFieldWidth: 300,
                                            decoration: InputDecoration(
                                                focusColor: kPrimaryColor,
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.only(top: 15),
                                                prefixIcon: Icon(
                                                  Icons.event,
                                                  color: kTextDisabledColor,
                                                  size: 20,
                                                ),
                                                suffixIcon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: kTextDisabledColor,
                                                  size: 20,
                                                ),
                                                suffixIconConstraints:
                                                    BoxConstraints(
                                                        minWidth: 30)),
                                            onChanged: (val) =>
                                                renderTime(DateTime.parse(val)),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Flexible(
                                child: Container(
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Số lượng",
                                        style:
                                            TextStyle(color: kTextThirdColor),
                                      ),
                                      SizedBox(height: 10),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            accentColor: Colors.amber,
                                          ),
                                          child: Material(
                                              color: Colors.transparent,
                                              textStyle: TextStyle(
                                                  color: kPrimaryColor),
                                              child: TextField(
                                                controller: fieldText,
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 15, left: 10),
                                                    border:
                                                        OutlineInputBorder(),
                                                    suffixText: "người",
                                                    suffixIcon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: kTextDisabledColor,
                                                      size: 20,
                                                    ),
                                                    suffixIconConstraints:
                                                        BoxConstraints(
                                                            minWidth: 30),
                                                    suffixStyle: TextStyle(
                                                        color:
                                                            kTextDisabledColor)),
                                                onTap: () =>
                                                    showMaterialNumberPicker(
                                                  context: context,
                                                  title: "Số lượng",
                                                  buttonTextColor:
                                                      kPrimaryColor,
                                                  headerTextColor: Colors.white,
                                                  maxNumber: 9999,
                                                  minNumber: 1,
                                                  step: 1,
                                                  confirmText: "OK",
                                                  cancelText: "Hủy",
                                                  selectedNumber: _currentValue,
                                                  onChanged: (value) =>
                                                      setState(() => {
                                                            _currentValue =
                                                                value,
                                                            fieldText.text =
                                                                _currentValue
                                                                    .toString()
                                                          }),
                                                ),
                                              )))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ])),
              Container(
                height: 100.0,
                padding: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listTime.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (userBloc.diner == null) {
                          Fluttertoast.showToast(
                              msg: "Bạn cần đăng nhập để thực hiện chức năng này!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              timeInSecForIosWeb: 5);
                        } else {
                          restaurantBloc.add(ConfirmReservation(
                              idVoucher: (restaurantBloc.listVouchers != null &&
                                      restaurantBloc.listVouchers.length > 0)
                                  ? restaurantBloc.listVouchers[0].id
                                  : null,
                              numberPerson: int.parse(fieldText.text),
                              time: listTime[index],
                              code: (restaurantBloc.listVouchers != null &&
                                      restaurantBloc.listVouchers.length > 0)
                                  ? restaurantBloc.listVouchers[0].code
                                  : null,
                              idUser: userBloc.diner.id));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                      value: restaurantBloc,
                                      child: ReservationConfirm())));
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 55,
                        margin: index == 4
                            ? EdgeInsets.only(left: 20.0, right: 20.0)
                            : EdgeInsets.only(left: 20.0, right: 0.0),
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  listTime[index].hour.toString() +
                                      ":" +
                                      (listTime[index].minute == 0
                                          ? "00"
                                          : listTime[index].minute.toString()),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  (restaurantBloc.listVouchers != null &&
                                          restaurantBloc.listVouchers.length >
                                              0)
                                      ? restaurantBloc.listVouchers[0].code
                                      : "ĐẶT CHỖ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
