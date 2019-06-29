import 'dart:io';

import 'package:attendance_client/pages/managerPage.dart';
import 'package:attendance_client/pages/personalPage.dart';
import 'package:attendance_client/pages/teamPage.dart';
import 'package:attendance_client/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return MaterialApp(
      initialRoute: "/",
      routes: <String,WidgetBuilder>{
        "/":(context) => WelcomePage(),
        "/managerPage": (context) => ManagerHomePage(),
        '/personalPage': (context) => PersonalPage(),
        '/teamPage': (context) => TeamPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
