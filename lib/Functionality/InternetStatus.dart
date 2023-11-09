import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cims/Screens/globals.dart' as globals;

bool status = true;
  late StreamSubscription subscription;

class ConnectivityHelper {
  static void activeStatus(BuildContext context) async {
    globals.con_result = await Connectivity().checkConnectivity();
    globals.isInternet = await InternetConnectionChecker().hasConnection;

    if (globals.con_result == ConnectivityResult.wifi) {
      print("globals.con_result\n");
      status = true;
      globals.colour = Colors.green;
    } else if (globals.con_result == ConnectivityResult.mobile) {
      globals.colour = Colors.orange;
    } else if (globals.con_result == ConnectivityResult.none) {
      status = false;
      globals.colour = Colors.red;
      print(globals.con_result);
      print("globals.con_result\n");
      print(globals.isInternet);
    }

    // Call setState to trigger a rebuild of the widget with updated status
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(" ${status ? 'Back Online' : 'Offline mode active'}"),
      ),
    );
  } static void startStreaming(BuildContext context) {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
    activeStatus(context);
    });
  }

}