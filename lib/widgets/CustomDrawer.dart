import 'dart:async';
import 'dart:ui';
import 'package:cims/Screens/Forms.dart';
import 'package:cims/Screens/routine.dart';
import 'package:cims/Screens/splashscreen.dart';
import 'package:cims/data/data.dart';
import 'package:cims/screens/Attendance.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cims/screens/slider.dart';
import 'package:cims/styles/app_colors.dart';
import 'package:cims/Screens/Settings.dart';
import 'package:cims/Screens/Profile.dart';
import 'package:cims/Screens/Assignment.dart';
import 'package:cims/Screens/ClassViewer.dart';
import 'package:cims/Screens/Analytics.dart';
import 'package:cims/Screens/Login.dart';
import 'package:cims/Screens/Results.dart';
import 'package:cims/Screens/Notices.dart';
import 'package:cims/Screens/Notes.dart';
import 'package:cims/Model/variable.dart' as information;
import 'package:cims/Screens/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Drawer2 extends StatelessWidget {
  const Drawer2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //dynamic _email = TextEditingController(text: g_email);
    return Drawer(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 90, 40, 0),
        children: [
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 750,
                width: 10,
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.difference,
                  borderRadius: BorderRadius.circular(30.0),
                  //backgroundBlendMode: BlendMode.colorBurn,
                  color: const Color.fromARGB(77, 97, 97, 97),
                ),
                child: ListView(children: [
                  MyDraweer(
                    val: "Profile",
                    fun: Icons.person,
                    taptap: Profile(),
                  ),
                  MyDraweer(
                    val: "Attendance",
                    fun: Icons.assessment,
                    taptap: const Attendance(),
                  ),
                  MyDraweer(
                    val: "Notes",
                    fun: Icons.notes,
                    taptap: Notes(),
                  ),
                  MyDraweer(
                    val: "Results",
                    fun: Icons.account_box_outlined,
                    taptap: const Results(),
                  ),
                  MyDraweer(
                      val: "Routine",
                      fun: Icons.calendar_month,
                      taptap: const Routine()),
                  MyDraweer(
                    val: "Notices",
                    fun: Icons.book,
                    taptap: const Notices(),
                  ),
                  MyDraweer(
                    val: "Assignment",
                    fun: Icons.assignment,
                    taptap: Assignment(
                      Classname: " ",
                      focuseditem: 0,
                    ),
                  ),
                  MyDraweer(
                    val: "Forms     ",
                    fun: Icons.edit_document,
                    taptap: const Forms(),
                  ),
                  MyDraweer(
                    val: "Analytics",
                    fun: Icons.edit_document,
                    taptap: Analytics(),
                  ),
                  MyDraweer(
                    val: "Settings",
                    fun: Icons.settings,
                    taptap: const Settings(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/ccmt1.png"),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            //backgroundBlendMode: BlendMode.colorBurn,
                            color: const Color.fromARGB(130, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Row(children: [
                              GestureDetector(
                                onTap: () async {
                                  var sharedPref =
                                      await SharedPreferences.getInstance();
                                  sharedPref.setBool(
                                      SplashScreen.KEYLOGIN, false);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ButtonStates(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              )),
        ],
      ),
    );
  }

  Future<void> active_status() async {
    globals.con_result = await Connectivity().checkConnectivity();
    globals.isInternet = await InternetConnectionChecker().hasConnection;

    if (globals.con_result == ConnectivityResult.wifi) {
      print("globals.con_result\n");
      globals.colour = Colors.green;
    } else if (globals.con_result == ConnectivityResult.mobile) {
      globals.colour = Colors.orange;
    } else if (globals.con_result == ConnectivityResult.none) {
      globals.colour = Colors.pink;
      print(globals.con_result);
      print("globals.con_result\n");
      print(globals.isInternet);
    }
  }
}

class MyDraweer extends StatelessWidget {
  var val;
  var fun;
  var taptap;

  MyDraweer(
      {required this.val, required this.fun, required this.taptap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.5, 12, 5.5, 12),
      child: InkWell(
        onTap: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => taptap)),
        child: Container(
          height: 42,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            //backgroundBlendMode: BlendMode.colorBurn,
            color: Color.fromARGB(130, 0, 0, 0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    val,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Icon(
                      fun,
                      color: Colors.white,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}