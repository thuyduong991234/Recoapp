import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/page/user/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textUserName = TextEditingController();
  final textPassword = TextEditingController();

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
                        "ĐĂNG NHẬP",
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
                              'assets/image1.PNG',
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
                                child: Text("ĐĂNG NHẬP".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 5),
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
                                userBloc.add(LoginEvent(username: textUserName.text, password: textPassword.text, context: context))
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
                                            child: RegisterPage(),
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bạn chưa có tài khoản? ",
                                  style: TextStyle(
                                      fontSize: 14, color: kTextDisabledColor),
                                ),
                                Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      fontSize: 14, color: kThirdColor),
                                )
                              ],
                            ),
                          )),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: kTextDisabledColor,
                                    height: 1.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "HOẶC",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: kTextDisabledColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(FontAwesomeIcons.facebookF,
                                      color: kPrimaryColor, size: 25),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  userBloc.add(LoginWithGoogleEvent(context: context));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: kPrimaryColor,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(FontAwesomeIcons.googlePlusG,
                                      color: kPrimaryColor, size: 25),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )));
        });
  }
}
