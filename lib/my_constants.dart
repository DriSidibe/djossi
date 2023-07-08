import 'package:djossi/main.dart';
import 'package:djossi/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'base.dart';
import 'login_screen.dart';
import 'my_classes.dart';

Color myPrimaryColor = Colors.blue;
double myTitleFontSize = 30.0;
double myTextBigFontSize = 20.0;
double myTextSmallFontSize = 10.0;
double myTextSmallFontSize2 = 12.0;
double myTextMediumFontSize = 15.0;
double myTextMediumFontSize2 = 17.0;

double myIconSmallSize = 15;

FontWeight myNormalFontWeight = FontWeight.w300;
FontWeight myNormalFontWeight2 = FontWeight.w200;

List<double> screenSize(context) {
  return [
    MediaQuery.of(context).size.width,
    MediaQuery.of(context).size.height
  ];
}

Worker defaultWorker = Worker(
  0,
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  0,
  "",
);

List<Color> colorsList = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.black,
  Colors.pink,
  const Color.fromARGB(255, 8, 210, 79),
  Colors.pink,
  const Color.fromARGB(255, 76, 49, 81),
];

InputDecoration myInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(color: myPrimaryColor),
  ),
);

// GoRouter configuration
final myRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:
          'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const Registrer(),
    ),
    GoRoute(
      name: 'base',
      path: '/base',
      builder: (context, state) => const Base(),
    ),
    GoRoute(
      name: 'welecome',
      path: '/welecome',
      builder: (context, state) => const WelcomeScreen(),
    ),
  ],
);

List<String> allowImageExtensions = [
  ".img",
  ".IMG",
  ".jpg",
  ".JPG",
  ".jpeg",
  ".JPEG",
  ".png",
  ".PNG",
];

//DB settings
String dbServerName = "192.168.1.191";
String ftpServerUsername = 'drissa';
String ftpServerPassword = 'what up?';
int ftpServerPort = 21;
String dbServerPort = "8000";
String socket = "$dbServerName:$dbServerPort";
