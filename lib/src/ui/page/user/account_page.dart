import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final textName = TextEditingController();
  final textAddress = TextEditingController();
  final textEmail = TextEditingController();
  final textPhone = TextEditingController();
  DateTime dob;

  var _value = 0;

  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    textName.text = userBloc.diner.fullname;
    textAddress.text = userBloc.diner.address;
    textEmail.text = userBloc.diner.email;
    textPhone.text = userBloc.diner.phone;
    dob = userBloc.diner.dob;
    _value = userBloc.diner.gender;
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
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(""),
                leading: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: kPrimaryColor,
                      icon: Icon(Icons.arrow_back_ios_rounded,
                          color: kPrimaryColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                actions: [
                  Material(
                      color: Colors.transparent,
                      child: IconButton(
                        splashColor: kPrimaryColor,
                        icon: Icon(Icons.check_rounded, color: kPrimaryColor),
                        onPressed: () {
                          userBloc.add(UpdateAccountInfoEvent(
                            context: context,
                            fullname: textName.text,
                            phone: textPhone.text,
                            email: textEmail.text,
                            address: textAddress.text,
                            dob: dob,
                            gender: _value
                          ));
                        },
                      ))
                ],
              ),
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          ClipOval(
                            child: Image.network(
                              userBloc.diner.avatar != null &&
                                      userBloc.diner.avatar.isNotEmpty
                                  ? userBloc.diner.avatar
                                  : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA-Jw0QFuiDlVykI47JOPtuhYbxIhnM77tkw&usqp=CAU',
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                              top: 50,
                              left: 70,
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90)),
                                    color: kPrimaryColor,
                                    child: IconButton(
                                      splashColor: kPrimaryColor,
                                      icon: Icon(Icons.add_a_photo,
                                          color: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.user,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Tên của bạn",
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "(*)",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0),
                                        )
                                      ],
                                    ),
                                    TextField(
                                      controller: textName,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          hintText:
                                              "Nhập username hoặc tên của bạn",
                                          hintStyle: TextStyle(
                                              color: kTextDisabledColor)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.phoneAlt,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Số điện thoại",
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "(*)",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0),
                                        )
                                      ],
                                    ),
                                    TextField(
                                      controller: textPhone,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText:
                                              "Nhập số điện thoại liên hệ",
                                          hintStyle: TextStyle(
                                              color: kTextDisabledColor)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.envelope,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "(*)",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0),
                                        )
                                      ],
                                    ),
                                    TextField(
                                      controller: textEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          hintText: "Nhập email",
                                          hintStyle: TextStyle(
                                              color: kTextDisabledColor)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.streetView,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Địa chỉ",
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "(*)",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.0),
                                        )
                                      ],
                                    ),
                                    TextField(
                                      controller: textAddress,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText: "Nhập địa chỉ",
                                          hintStyle: TextStyle(
                                              color: kTextDisabledColor)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.birthdayCake,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ngày sinh",
                                      style: TextStyle(
                                          color: kTextThirdColor,
                                          fontSize: 16.0),
                                    ),
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
                                                userBloc.diner.dob.toString(),
                                            firstDate: DateTime(1),
                                            lastDate: DateTime(2100),
                                            timeFieldWidth: 300,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(top: 15),
                                                suffixIcon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: kTextDisabledColor,
                                                  size: 20,
                                                ),
                                                suffixIconConstraints:
                                                    BoxConstraints(
                                                        minWidth: 30)),
                                            onChanged: (val) => {
                                                  setState(() {
                                                    dob = DateTime.parse(val);
                                                  })
                                                }))
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.transgender,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Giới tính",
                                      style: TextStyle(
                                          color: kTextThirdColor,
                                          fontSize: 16.0),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Radio(
                                          activeColor: kPrimaryColor,
                                          value: 2,
                                          groupValue: _value,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Nữ',
                                          style: TextStyle(
                                              color: kTextThirdColor,
                                              fontSize: 16.0),
                                        ),
                                        Radio(
                                          activeColor: kPrimaryColor,
                                          value: 1,
                                          groupValue: _value,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Nam',
                                          style: TextStyle(
                                            color: kTextThirdColor,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )));
        });
  }
}
