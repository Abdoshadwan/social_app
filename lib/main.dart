import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_app/cache/cache.dart';
import 'package:social_app/layout/home_page.dart';
import 'package:social_app/modules/Login/Login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/Cubit/blocobserver.dart';
import 'package:social_app/shared/Cubit/cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
  showtost(message: 'on background message', statuss: toaststates.success);
}

void main() async {
  Widget widget = Login();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showtost(message: 'on message', statuss: toaststates.success);
  });
  await FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showtost(message: 'on opened message', statuss: toaststates.success);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  await Cache_Helper.Init();
  uid = Cache_Helper.getsaved(key: 'uid') ?? 'null';
  print(uid.toString());
  if (uid != 'null') {
    widget = home();
  } else {
    widget = Login();
  }
  runApp(MyApp(
    startscreen: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startscreen;
  MyApp({
    required this.startscreen,
  });

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: uid == 'null'
          ? (context) => Social_Cubit()
          : (context) => Social_Cubit()
            ..getuserdata()
            ..getposts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        home: startscreen,
      ),
    );
  }
}
