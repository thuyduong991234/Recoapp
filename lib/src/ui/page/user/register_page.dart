import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/user/account_page.dart';
import 'package:recoapp/src/ui/page/user/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final textUserName = TextEditingController();
  final textPassword = TextEditingController();
  final textEmail = TextEditingController();

  var _value = true;

  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    _value = true;
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
              ),
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        "ĐĂNG KÝ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: kPrimaryColor),
                      ),
                    ),
                    Center(
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/image2.PNG',
                              width: 150,
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
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
                                          "Username",
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
                                      controller: textUserName,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          hintText: "Nhập username của bạn",
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
                                          hintText: "Nhập email của bạn",
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
                              Icon(Icons.lock_outline_rounded,
                                  color: kTextThirdColor, size: 25),
                              SizedBox(width: 6),
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
                                      obscureText: _value,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      controller: textPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: InputDecoration(
                                          suffix: _value
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
                                                      _value = false;
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
                                                      _value = true;
                                                    });
                                                  }),
                                          hintText: "Nhập password",
                                          hintStyle: TextStyle(
                                              color: kTextDisabledColor)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          TextButton(
                              child: Padding(
                                child: Text("ĐĂNG KÝ".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 110, vertical: 5),
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(10)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color: kPrimaryColor)))),
                              onPressed: () => {
                                    userBloc.add(RegisterEvent(
                                        username: textUserName.text,
                                        password: textPassword.text,
                                        email: textEmail.text, context: context))
                                  }),
                          SizedBox(height: 40),
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                            value: userBloc,
                                            child: LoginPage(),
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bạn đã có tài khoản? ",
                                  style: TextStyle(
                                      fontSize: 14, color: kTextDisabledColor),
                                ),
                                Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      fontSize: 14, color: kThirdColor),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              )));
        });
  }
}
