import 'package:cims/APIs/APIattendance.dart';
import 'package:cims/APIs/APIuserinfo.dart';
import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Utils.dart';
import 'package:cims/widgets/attendancewidget.dart';
import 'package:cims/Screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cims/Model/variable.dart' as information;
import 'package:cims/widgets/DismissibleWidget.dart';
import 'globals.dart' as globals;

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<AttendanceData> dataList = [];

  @override
  void initState() {
    super.initState();
  }

  dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
  ) {
    switch (direction) {
      case DismissDirection.endToStart:
        DELETEAttendanceData(
          userId: dataList[index].user_id.toString(),
          profilePic: '',
          userName: '',
          time: '',
          date: '',
        );
        dataList.removeAt(index); // Remove the dismissed item from the list
        // setState(() {});
        Utils.showSnackBar_red(context, 'Recorded as absent');
        break;
      case DismissDirection.startToEnd:
        Utils.showSnackBar_green(context, 'Recorded as present');
        break;
      default:
        break;
    }
  }

  void fetchAData(data) async {
    try {
      final List<AttendanceData> fetchedData = await fetchATData(data);
      setState(() {
        dataList = fetchedData;
        print(dataList);
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      if (i == 0) {
        userProvider.loadUserInfo();
        i = 1;
      } else {}
    } catch (e) {} // access the instance
    // call the instance method
    if (i == 1) {
      fetchAData(userProvider.userId);
      print(i);
      i++;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Management',
      themeMode: ThemeMode.system,
      theme: globals.ThemeClass.lightTheme,
      darkTheme: globals.ThemeClass.darkTheme,
      home: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            // shadowColor: Colors.transparent,
            // backgroundColor: const Color.fromARGB(255, 10, 9, 26),
            // automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      ID: information.ID,
                    ),
                  ),
                ),
                i = 1,
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0, 30),
                  child: Text(
                    "Attendance Applications list",
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.5),
                        height: 700,
                        width: 1200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: userProvider.userRole == 't'
                            ? ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  final item = dataList[index];

                                  return DismissibleWidget(
                                    Key: ValueKey(item.user_id),
                                    item: index,
                                    child: ClassViewer(
                                      Teacher:
                                          dataList[index].user_id.toString(),
                                      Subject: dataList[index].Name.toString(),
                                      Time: dataList[index].time.toString(),
                                      box: dataList[index]
                                          .profile_pic
                                          .toString(),
                                    ),
                                    onDismissed: (direction) =>
                                        dismissItem(context, index, direction),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  final item = dataList[index];

                                  return ClassViewer(
                                    Teacher: dataList[index].user_id.toString(),
                                    Subject: dataList[index].Name.toString(),
                                    Time: dataList[index].time.toString(),
                                    box: dataList[index].profile_pic.toString(),
                                  );
                                },
                              ),
                      ),
                      Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(330, 638, 10, 0),
                          child: userProvider.userRole == 't'
                              ? FloatingActionButton(
                                  backgroundColor:
                                      Color.fromARGB(255, 112, 27, 22),
                                  splashColor: Colors.amber,
                                  child: Icon(Icons.add),
                                  onPressed: () {
                                    _showIDInputPopup(context, "Add");
                                  },
                                )
                              : Container()),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _showIDInputPopup(BuildContext context, String vara) {
    final TextEditingController idController = TextEditingController();
    //String enteredID = "idController.text";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus(); // Dismiss keyboard
            },
            child: Column(children: [
              AlertDialog(
                title: Text(
                  'Enter student ID',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: idController,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'ID'),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.black
                    .withOpacity(0.5), // Set translucent background color
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      vara = idController.text;
                      _showIDInputPopup(context, vara);
                      print('Entered ID: $vara');
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
              vara == "Add"
                  ? Container(
                      width: 140,
                      height: 14,
                      //color: Colors.blueGrey,
                    )
                  : AlertDialog(
                      backgroundColor: Colors.transparent,
                      title: Text(' $vara Added to the list',
                          style: TextStyle(color: Colors.green, fontSize: 13)),
                    )
            ]),
          ),
        );
      },
    );
  }
}