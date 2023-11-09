import 'dart:async';
import 'dart:convert';
import 'package:cims/APIs/APIattendance.dart';
import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Functionality/Device_Id.dart';
import 'package:cims/Model/Variable.dart';
import 'package:cims/Screens/globals.dart';
import 'package:cims/Screens/splashscreen.dart';
import 'package:cims/Screens/test.dart';
import 'package:cims/widgets/CustomDrawer.dart';
import 'package:cims/widgets/customdialog.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:cims/screens/slider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:cims/APIs/APIuserinfo.dart';
import 'package:cims/APIs/APIroutine.dart';
import 'package:cims/APIs/APIteacher_routine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ToggleButton.dart';
import 'Profile.dart';
import 'ClassViewer.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart'; // Import the intl package for formatting

bool setter = false;
dynamic i = 0;
TimeOfDay currentTime = TimeOfDay.now();
String formattedTime = formatTimeOfDay(currentTime);
String formattedDate = formatDay(currentTime);
// Function to format TimeOfDay to a string
String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();

  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final format = DateFormat.jm(); // Use the desired time format
  return format.format(dateTime);
}

String formatDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final Date = DateTime(now.year, now.month, now.day);
  // final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final format = DateFormat.jm(); // Use the desired time format
  return format.format(Date);
}

class HomeScreen extends StatefulWidget {
  final String ID;
  HomeScreen({
    Key? key,
    required this.ID,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future main() async {
  globals.con_result = await Connectivity().checkConnectivity();
  globals.isInternet = await InternetConnectionChecker().hasConnection;
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  print("globals.con_result\n");
  print(globals.isInternet);
}

class _HomeScreenState extends State<HomeScreen> {
  final webchannel = IOWebSocketChannel.connect(globals.wsIP);

  List<RoutineData> dataList = [];
  List<TeacherRoutineData> teacherdataList = [];
  List<EventData> eventList = [];
  late ConnectivityResult result;
  late StreamSubscription subscription;
  bool status = true;

  // get userProvider => null;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    startStreaming();
    notti();
    if (widget.ID != "") {
      print("---------------------------------------------------------------" +
          widget.ID);
      fetchDataFromServer(widget.ID);
      fetchInfoFromServer(); //DONOT CHANGE THIS
      // Call the function to fetch data
    }
  }

  Future<void> fetchDataFromServer(ID) async {
    try {
      // final List<TeacherRoutineData> fetchedteacherData =
      //     await fetchteacherDataToday();
      //print('fetchedData length: ${fetchedData.length}');
      if (ID != "") {
        await userDetails(ID);
        await uni_Details(ID);
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> fetchInfoFromServer() async {
    try {
      final List<RoutineData> fetchedData = await fetchDataToday();
      final List<EventData> fetchedEData = await fetchEData();
      dataList = fetchedData;
      eventList = fetchedEData;
    } catch (e) {}
  }

  Future<void> notti() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(SplashScreen.KEYLOGIN);
    Timer(Duration(seconds: 2), () async {
      try {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            NotificationCaller();
          } else {}
        }
      } catch (e) {
        print('Error fetching token: $e');
      }
    });
  }

  showDialogBox() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(title: const Text("data")));
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
      // print(globals.con_result);
      // print("globals.con_result\n");
      // print(globals.isInternet);
      // setter = true;
    }
    setState(() {});
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      activeStatus();
    });
  }

  Future<void> _handleRefresh() async {
    {
      print(SplashScreen.KEYLOGIN);
      await Future.delayed(const Duration(seconds: 1));
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
        // print(globals.con_result);
        // print("globals.con_result\n");
        // print(globals.isInternet);
      }
      await Future.delayed(const Duration(microseconds: 50));
      print("Exited refresh");
      //userProvider.loadUserInfo();
      setter = true;
      setState(() {});
    }

    // Function to fetch data from the server
  }

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context); // Access userProvider directly
    try {
      if (i == 0) {
        userProvider.loadUserInfo();
        i = 1;
      } else {}
      fetchDataFromServer(userProvider.userId);
      fetchInfoFromServer();
    } catch (e) {}
    print(setter);
    if (setter == true) {
      userProvider.userRole == 's'
          ? pushAttendanceData(
              userId: userProvider.userId,
              userName: userProvider.userName,
              date: formattedDate,
              time: formattedTime,
              profilePic: userProvider.profilePic,
            )
          : print('lol');
      setter = false;
    } // access the instance

    // call the instance method
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Management',
      themeMode: ThemeMode.system,
      theme: globals.ThemeClass.lightTheme,
      darkTheme: globals.ThemeClass.darkTheme,
      home: Scaffold(
        appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                      backgroundColor: Color.fromARGB(255, 5, 8, 52),
                      backgroundImage: NetworkImage(userProvider.profilePic),
                      radius: 20,
                    ),
                  ),
                ),
              ),
            ]),
        drawer: const Drawer2(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: LiquidPullToRefresh(
          onRefresh: _handleRefresh,
          color: const Color.fromARGB(99, 52, 51, 67),
          child: ListView(children: [
            Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 1200,
                  child: userProvider.userRole == 's' &&
                          globals.ServerConnection == true
                      ? status == true
                          ? const Icon(
                              Icons.arrow_circle_down,
                              size: 25,
                              //color: Color.fromARGB(170, 255, 255, 225),
                            )
                          : const Icon(
                              Icons.signal_wifi_connected_no_internet_4_rounded,
                              size: 25,
                              //color: Color.fromARGB(255, 255, 255, 225),
                            )
                      : globals.ServerConnection == false
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                              child: Container(
                                height: 40,
                                width: 1200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(120, 128, 127, 127),
                                  borderRadius: BorderRadius.circular(30.0),
                                  //color: const Color.fromARGB(255, 218, 0, 33),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Unable to connect to server, Loading older data...",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                ),
                userProvider.userRole == 's' && globals.ServerConnection == true
                    ? status == true
                        ? const Text(
                            "Pull down for Attendance",
                            style: TextStyle(
                                //color: Color.fromARGB(170, 255, 255, 225),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        : const Text(
                            "You're currently offline",
                            style: TextStyle(
                                //color: Color.fromARGB(170, 255, 255, 225),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                    : Container(),
                Container(
                  color: Colors.transparent,
                  key: UniqueKey(),
                  child: MYSlider(focusedIndex: 0),
                  alignment: Alignment.topLeft,
                  height: 150,
                  width: 1200,
                ),
                Container(
                  //child: MYSlider(),
                  height: 100,
                  width: 1200,
                  //color: Color.fromARGB(255, 170, 16, 42),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(130, 25, 130, 25),
                    height: 10,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: const Color.fromARGB(255, 127, 24, 32),
                    ),
                    child: Stack(
                      children: [
                        ToggleButton(),
                        Row(
                          children: [
                            FloatingActionButton.extended(
                              heroTag: 'contact',
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              elevation: 0,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  globals.Current = true;
                                  globals.xAlign = globals.loginAlign;
                                  globals.loginColor = globals.selectedColor;
                                  globals.signInColor = globals.normalColor;
                                });
                              },
                              label: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 35),
                                  ),
                                ],
                              ),
                            ),
                            FloatingActionButton.extended(
                              foregroundColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              elevation: 0,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Tracking()));
                                setState(() {
                                  globals.xAlign = globals.signInAlign;
                                  globals.signInColor = globals.selectedColor;
                                  globals.loginColor = globals.normalColor;
                                  globals.Current = false;
                                });
                              },
                              label: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 35),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 00),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.5),
                      height: 450,
                      width: 1200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor),
                      child: globals.Current == true
                          ? userProvider.userRole == 's'
                              ? ListView.builder(
                                  itemCount: dataList.length,
                                  itemBuilder: (context, index) {
                                    RoutineData data = dataList[index];
                                    List<String> parts = (data.time).split(':');
                                    int hours = int.parse(parts[0]);
                                    int minutes = int.parse(parts[1]);

                                    TimeOfDay timeOfDay =
                                        TimeOfDay(hour: hours, minute: minutes);

                                    /// Define the duration to add (1 hour and 30 minutes)
                                    final durationToAdd =
                                        Duration(hours: 1, minutes: 30);

// Calculate the new total minutes
                                    final totalMinutes = timeOfDay.hour * 60 +
                                        timeOfDay.minute +
                                        durationToAdd.inMinutes;

// Calculate the new hour and minute values
                                    final newHour = totalMinutes ~/
                                        60; // ~/ performs integer division
                                    final newMinute = totalMinutes % 60;

// Create the new TimeOfDay
                                    final newTime = TimeOfDay(
                                        hour: newHour, minute: newMinute);

                                    String formattedTime =
                                        "${timeOfDay.hour}:${timeOfDay.minute.toString().padLeft(2, '0')} ${timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'}";
                                    final currentMinutes =
                                        currentTime.hour * 60 +
                                            currentTime.minute;
                                    final startMinutes =
                                        timeOfDay.hour * 60 + timeOfDay.minute;
                                    final endMinutes =
                                        newTime.hour * 60 + newTime.minute;

                                    // Check if the current time is within the specified range
                                    final isOngoing =
                                        currentMinutes >= startMinutes &&
                                            currentMinutes <= endMinutes;
                                    final notstarted =
                                        currentMinutes < startMinutes;
                                    // Display "ongoing" or "completed" based on the comparison
                                    String status;
                                    if (notstarted) {
                                      status = formattedTime;
                                    } else if (isOngoing) {
                                      status = "Ongoing";
                                    } else {
                                      status = "Completed";
                                    }

                                    return GestureDetector(
                                      onLongPress: () {
                                        showEditPopup(context, data.teacher,
                                            data.subject, formattedTime);
                                      },
                                      child: ClassViewer(
                                        Teacher: data.teacher,
                                        Subject: data.subject,
                                        Time: status,
                                        box: (data.subject)[0],
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  itemCount: teacherdataList.length,
                                  itemBuilder: (context, index) {
                                    TeacherRoutineData data =
                                        teacherdataList[index];
                                    List<String> parts = (data.time).split(':');
                                    int hours = int.parse(parts[0]);
                                    int minutes = int.parse(parts[1]);

                                    TimeOfDay timeOfDay =
                                        TimeOfDay(hour: hours, minute: minutes);

                                    /// Define the duration to add (1 hour and 30 minutes)
                                    final durationToAdd =
                                        Duration(hours: 1, minutes: 30);

// Calculate the new total minutes
                                    final totalMinutes = timeOfDay.hour * 60 +
                                        timeOfDay.minute +
                                        durationToAdd.inMinutes;

// Calculate the new hour and minute values
                                    final newHour = totalMinutes ~/
                                        60; // ~/ performs integer division
                                    final newMinute = totalMinutes % 60;

// Create the new TimeOfDay
                                    final newTime = TimeOfDay(
                                        hour: newHour, minute: newMinute);

                                    String formattedTime =
                                        "${timeOfDay.hour}:${timeOfDay.minute.toString().padLeft(2, '0')} ${timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'}";
                                    final currentMinutes =
                                        currentTime.hour * 60 +
                                            currentTime.minute;
                                    final startMinutes =
                                        timeOfDay.hour * 60 + timeOfDay.minute;
                                    final endMinutes =
                                        newTime.hour * 60 + newTime.minute;

                                    // Check if the current time is within the specified range
                                    final isOngoing =
                                        currentMinutes >= startMinutes &&
                                            currentMinutes <= endMinutes;
                                    final notstarted =
                                        currentMinutes < startMinutes;
                                    // Display "ongoing" or "completed" based on the comparison
                                    String status;
                                    if (notstarted) {
                                      status = formattedTime;
                                    } else if (isOngoing) {
                                      status = "Ongoing";
                                    } else {
                                      status = "Completed";
                                    }
                                    print(data);
                                    return ClassViewer(
                                      Teacher: data.subject,
                                      Subject: data.classroom,
                                      Time: status,
                                      box: (data.subject)[0],
                                    );
                                  },
                                )
                          : ListView.builder(
                              itemCount: eventList.length,
                              itemBuilder: (context, index) {
                                EventData data = eventList[index];

                                return NOTClassViewer(
                                  Teacher: data.organizer,
                                  Subject: data.topic,
                                  Time: data.time,
                                  box: (data.topic)[0],
                                );
                              },
                            )
                      // : Padding(
                      //     padding: EdgeInsets.fromLTRB(170, 30, 10, 0),
                      //     child: Container(
                      //       height: 10,
                      //       width: 80,
                      //       //color: Colors.blueAccent,
                      //       child: Text("छैन  कलास "),
                      //     ),
                      //   )
                      ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  void NotificationCaller() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(SplashScreen.KEYLOGIN);
    Timer(Duration(seconds: 2), () async {
      try {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            webchannel.stream.listen((data) {
              data = json.decode(data);
              schedulePeriodicNotifications(
                  ((data['message'])).toString(), ((data['title'])).toString());
              print(data);
            });
          } else {}
        }
      } catch (e) {
        print('Error fetching token: $e');
      }
    });
  }
}