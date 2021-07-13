import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recoapp/src/app.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_bloc.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_event.dart';
import 'package:recoapp/src/blocs/filter_bloc/filter_state.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_bloc.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_event.dart';
import 'package:recoapp/src/blocs/user_bloc/user_bloc/user_state.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final token = await messaging.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel_12', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiBlocProvider(
      child: App(),
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserInitial())
            ..add(InitialPositionEvent(
                latitude: 10.848285894133156, longtitude: 106.77430679731481))
            ..add(FetchRecommendNoUser())
            ..add(FetchRestaurantHistory()),
        ),
        BlocProvider<FilterBloc>(
          create: (BuildContext context) => FilterBloc(FilterInitial())
            ..add(GetFilterEvent())
            ..add(SendTokenFCM(token: token)),
        ),
      ],
    ),
  );
}
