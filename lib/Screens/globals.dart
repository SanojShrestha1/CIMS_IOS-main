library globals;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

String ID = '';
String Name = '';
String profile_Pic = '';
bool isInternet = false;
ConnectivityResult con_result = ConnectivityResult.none;
MaterialColor colour = Colors.green;
bool Current = true;
const double width = 145;
const double height = 40;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;
late double xAlign = loginAlign;
late Color loginColor = selectedColor;
late Color signInColor = normalColor;
var wsIP = 'ws://192.168.101.9:8080';
// ignore: non_constant_identifier_names
const ServerIP = 'http://103.155.183.33:3000/api/';
bool ServerConnection = false;

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    drawerTheme: DrawerThemeData(
        backgroundColor: Colors.transparent, scrimColor: Colors.transparent),
    //scaffoldBackgroundColor: Colors.transparent, // Change to transparent color
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    primaryColor: Color.fromARGB(77, 124, 120, 189),
    iconTheme: IconThemeData(color: Colors.black),
    fontFamily: 'Roboto',
    // textTheme: TextTheme(
    //   headline1: TextStyle(color: Colors.black), // Customize as needed
    //   headline2: TextStyle(color: Colors.black), // Customize as needed
    //   headline3: TextStyle(color: Colors.black), // Customize as needed
    //   // Add more text styles as needed
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    drawerTheme: DrawerThemeData(
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
    scaffoldBackgroundColor: const Color.fromARGB(255, 10, 9, 26),
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 10, 9, 26),
    ),
    primaryColor: const Color.fromARGB(255, 22, 21, 37),
    iconTheme: IconThemeData(color: Colors.white),
    fontFamily: 'Roboto',
    // textTheme: TextTheme(
    //   headline1: TextStyle(color: Colors.white), // Customize as needed
    //   headline2: TextStyle(color: Colors.white), // Customize as needed
    //   headline3: TextStyle(color: Colors.white), // Customize as needed
    //   // Add more text styles as needed
    // ),
  );
}