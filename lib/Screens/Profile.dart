import 'dart:async';
import 'package:cims/APIs/APIroutine.dart';
import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Screens/Analytics.dart';
import 'package:cims/Screens/ClassViewer.dart';
import 'package:cims/Screens/Home.dart';
import 'package:cims/widgets/CustomDrawer.dart';
import 'package:cims/Screens/routine.dart';
import 'package:cims/data/data.dart';
import 'package:cims/screens/Attendance.dart';
import 'package:cims/widgets/Performance_viewer.dart';
import 'package:cims/widgets/my_bargraph.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'EditProfile.dart';
import 'Profile.dart';
import 'Assignment.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'Results.dart';
import 'Notices.dart';
import 'Notes.dart';
import 'package:cims/Model/variable.dart' as information;
import 'globals.dart' as globals;

int i = 0;

class Profile extends StatefulWidget {
  //final String g_email;
  const Profile({
    Key? key,
    //required this.g_email,
  }) : super(key: key);

  State<Profile> createState() => _ProfileState();
}

Future main() async {
  globals.con_result = await Connectivity().checkConnectivity();
  globals.isInternet = await InternetConnectionChecker().hasConnection;
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  print("globals.con_result\n");
  print(globals.isInternet);
}

class _ProfileState extends State<Profile> {
  List<String> docIDs = [];
  late ConnectivityResult result;
  late StreamSubscription subscription;
  bool status = true;

  @override
  void initState() {
    super.initState();
    startStreaming();
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
      print(globals.con_result);
      print("globals.con_result\n");
      print(globals.isInternet);
    }
    setState(() {});
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
      
    } catch (e) {}
    if (i == 0) {
        userProvider.loadUserInfo();
        i = 1;
      }  // access the instance
    // call the instance
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  ID: information.ID,
                                ))),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(100, 5, 5, 0),
                        child: Hero(
                          tag: 'profilePic',
                          child: CircleAvatar(
                            backgroundColor: globals.colour,
                            radius: 53,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userProvider.profilePic),
                              radius: 50,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(60, 70, 0, 0),
                                child: IconButton(
                                  icon: new Icon(Icons.camera_alt,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Navigate to a new screen to display the profile picture
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePictureScreen(
                                          imageUrl: userProvider.profilePic,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 00),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.5),
                  height: 450,
                  width: 1200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).primaryColor),
                  child: GestureDetector(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(90, 10, 0, 10),
                              child: Text(
                                userProvider.userName,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                              child: IconButton(
                                icon:
                                    new Icon(Icons.email, color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              userProvider.userEmail,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                              child: IconButton(
                                icon: new Icon(Icons.computer,
                                    color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              "Bachelors in ${userProvider.userClass}",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                              child: IconButton(
                                icon: const Icon(Icons.app_registration,
                                    color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              userProvider.userReg,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 10, 0, 10),
                              child: IconButton(
                                icon:
                                    new Icon(Icons.school, color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              'Pokhara University',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                              child: IconButton(
                                icon: new Icon(Icons.perm_identity,
                                    color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              userProvider.userId,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                              child: IconButton(
                                icon:
                                    new Icon(Icons.grade, color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              userProvider.userRoll,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                              child: IconButton(
                                icon: new Icon(Icons.call, color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              userProvider.userPhone,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 10, 0, 10),
                              child: IconButton(
                                icon: new Icon(Icons.location_city,
                                    color: Colors.amber),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              userProvider.userAddress,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  //color: Colors.red,
                  // key: UniqueKey(),
                  child: PerformanceSlider(),
                  alignment: Alignment.topLeft,
                  height: 150,
                  width: 1200,
                ),
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Analytics()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProfilePictureScreen extends StatelessWidget {
  final String imageUrl;

  const ProfilePictureScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Picture'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit,
                color: Colors.white), // You can use any icon you prefer
            onPressed: () {
              // Handle the edit profile picture action
              // You can navigate to a screen where users can upload/change their profile picture
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePictureScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'profilePic', // Use the same tag as in the Profile widget
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}