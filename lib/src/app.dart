import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recoapp/src/ui/constants.dart';
import 'package:recoapp/src/ui/tab/tab_navigator.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: TextTheme(
              body1: TextStyle(color: kPrimaryColor),
              body2: TextStyle(color: kSecondaryColor))),
      home: TabNavigator(),
    );
  }
}
