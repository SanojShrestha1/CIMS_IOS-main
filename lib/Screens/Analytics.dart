import 'dart:async';
import 'package:cims/APIs/APIresult.dart';
import 'package:cims/Functionality/Cache.dart';
import 'package:lottie/lottie.dart';
import 'package:tuple/tuple.dart';

import 'package:cims/widgets/Performance_viewer.dart';
import 'package:cims/widgets/breakdown.dart';
import 'package:cims/widgets/my_bargraph.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';

import 'Profile.dart';

import 'globals.dart' as globals;

int i = 0;

class Analytics extends StatefulWidget {
  Analytics({
    Key? key,
    //required this.g_email,
  }) : super(key: key);

  State<Analytics> createState() => _AnalyticsState();
}

Future main() async {
  globals.con_result = await Connectivity().checkConnectivity();
  globals.isInternet = await InternetConnectionChecker().hasConnection;
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  print("globals.con_result\n");
  print(globals.isInternet);
}

class _AnalyticsState extends State<Analytics> {
  (List<String>, List<String>) dataList = ([], []);
  List<String> docIDs = [];
  late ConnectivityResult result;
  late StreamSubscription subscription;
  bool status = true;

  @override
  void initState() {
    super.initState();
    startStreaming();
  }

  activeStatus() async {
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
    setState(() {});
  }

  Future<void> fetchUserResultDetails(dar) async {
    // Call the function and set the data to dataList
    dataList = (await userResultDetails(dar))!;
    setState(() {}); // Trigger a rebuild to display the data
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      activeStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      if (i == 0) {
        userProvider.loadUserInfo();
        fetchUserResultDetails(userProvider.userRoll);
        //print("------------------------" + dataList[0].toString());
        i = 1;
      } else {}
    } catch (e) {} // access the instance
    // call the instance method
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Management',
      themeMode: ThemeMode.system,
      theme: globals.ThemeClass.lightTheme,
      darkTheme: globals.ThemeClass.darkTheme,
      home: 
        Scaffold(
          appBar: AppBar(
            //backgroundColor: const Color.fromARGB(255, 10, 9, 26),
            elevation: 0.0,
            title: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              // child: Row(children: <Widget>[]),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.5),
                child: CircleAvatar(
                  backgroundColor: globals.colour,
                  radius: 23,
                  child: GestureDetector(
                    onTap: (() {
                      {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      }
                      ;
                    }),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userProvider.profilePic),
                      radius: 20,
                    ),
                  ),
                ),
              ),
            ],
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  i = 0;
                  Navigator.pop(context);
                }),
          ),
          //backgroundColor: const Color.fromARGB(255, 10, 9, 26),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Max Size
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                  child: Text(
                    "This semester",
                    style: TextStyle(
                        //color: Color.fromARGB(155, 255, 255, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: Text(
                    "Performance Chart",
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Container(
                  //color: Colors.amber,
                  key: UniqueKey(),
                  alignment: Alignment.center,
                  height: 200,
                  width: 1200,
                  child: Container(
                    key: UniqueKey(),
                    alignment: Alignment.bottomCenter,
                    height: 200,
                    width: 1200,
                    child: dataList.$1.isNotEmpty
                        ? barGraph(result: dataList.$1, subject: dataList.$2)
                        : Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                            child: Container(height:100,width:100,child: Lottie.asset('assets/images/splash_screen.json')),
                          ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Breakdown",
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),

                dataList.$1.isNotEmpty
                    ? Container(
                        //color: Colors.amber,
                        key: UniqueKey(),
                        alignment: Alignment.center,
                        height: 100,
                        width: 1200,
                        color: Color.fromARGB(119, 39, 40, 45),
                        child: breakdown(
                            result: dataList.$1, subject: dataList.$2),
                        // Replace with the correct field
                        // Add more ListTile properties as needed
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                        child: Container(height:100,width:100,child: Lottie.asset('assets/images/splash_screen.json')),
                      ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "College Exam",
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Container(
                  height: 150,
                  width: 1200,
                  child: PerformanceSlider(),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "University Exam",
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Container(
                  height: 150,
                  width: 1200,
                  child: PerformanceSlider(),
                ),
              ]),
        ));
  }
}