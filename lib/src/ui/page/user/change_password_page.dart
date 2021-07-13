import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final textCurrentPassword = TextEditingController();
  final textNewPassword = TextEditingController();
  final textConfirmPassword = TextEditingController();

  var _valueOne = true;

  var _valueTwo = true;

  var _valueThree = true;

  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    _valueOne = true;

    _valueTwo = true;

    _valueThree = true;
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
                          userBloc.add(ChangePasswordEvent(
                              newPassword: textNewPassword.text,
                              currentPassword: textCurrentPassword.text,
                              confirmPassword: textConfirmPassword.text,
                              context: context));
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
                      child: ClipOval(
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
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(FontAwesomeIcons.lock,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Password",
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
                                      obscureText: _valueOne,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      controller: textCurrentPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                          suffix: _valueOne
                                              ? IconButton(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 24),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  icon: Icon(Icons.visibility,
                                                      color: kTextDisabledColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    setState(() {
                                                      _valueOne = false;
                                                    });
                                                  })
                                              : IconButton(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 24),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  icon: Icon(
                                                      Icons.visibility_off,
                                                      color: kTextDisabledColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    setState(() {
                                                      _valueOne = true;
                                                    });
                                                  }),
                                          hintText: "Nhập password hiện tại",
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
                              Icon(FontAwesomeIcons.key,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Password mới",
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
                                      obscureText: _valueTwo,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      controller: textNewPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                          suffix: _valueTwo
                                              ? IconButton(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 24),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  icon: Icon(Icons.visibility,
                                                      color: kTextDisabledColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    setState(() {
                                                      _valueTwo = false;
                                                    });
                                                  })
                                              : IconButton(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 24),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  icon: Icon(
                                                      Icons.visibility_off,
                                                      color: kTextDisabledColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    setState(() {
                                                      _valueTwo = true;
                                                    });
                                                  }),
                                          hintText: "Nhập password mới",
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
                              Icon(FontAwesomeIcons.checkCircle,
                                  color: kTextThirdColor, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Xác nhận password mới",
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
                                      obscureText: _valueThree,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      controller: textConfirmPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                          suffix: _valueThree
                                              ? IconButton(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 24),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  icon: Icon(Icons.visibility,
                                                      color: kTextDisabledColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    setState(() {
                                                      _valueThree = false;
                                                    });
                                                  })
                                              : IconButton(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 24),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  icon: Icon(
                                                      Icons.visibility_off,
                                                      color: kTextDisabledColor,
                                                      size: 20),
                                                  onPressed: () {
                                                    setState(() {
                                                      _valueThree = true;
                                                    });
                                                  }),
                                          hintText: "Nhập lại password mới",
                                          hintStyle: TextStyle(
                                              color: kTextDisabledColor)),
                                    ),
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
