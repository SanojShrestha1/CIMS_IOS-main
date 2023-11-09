import 'dart:ui';
import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Screens/Home.dart';
import 'package:cims/widgets/customdialog.dart';
import 'package:cims/widgets/impro_slider.dart';
import 'package:cims/widgets/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'globals.dart' as globals;
import 'package:cims/Model/variable.dart' as information;

class Assignment extends StatefulWidget {
  final String Classname;
  final int focuseditem;
  Assignment({
    required this.Classname,
    required this.focuseditem,
    Key? key,
  }) : super(key: key);

  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      if (i == 0) {
        userProvider.loadUserInfo();
        i = 1;
      } else {}
    } catch (e) {} // access the instance
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assignment',
        themeMode: ThemeMode.system,
        theme: globals.ThemeClass.lightTheme,
        darkTheme: globals.ThemeClass.darkTheme,
        home: Scaffold(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          body: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ListView(children: [
              // Text(
              //   widget.Classname.toString(),
              //   style: TextStyle(
              //       color: Color.fromARGB(170, 255, 255, 225),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 12),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Max Size
                  IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Container(
                    color: Colors.transparent,
                    key: UniqueKey(),
                    child: MYimproSlider(
                      focusedIndex: widget.focuseditem,
                    ),
                    alignment: Alignment.topLeft,
                    height: 150,
                    width: 1200,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                    child: Row(
                      children: [
                        Text(
                          "Assignments",
                          style: TextStyle(
                              //color: Color.fromARGB(255, 255, 255, 225),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        userProvider.userRole == 't'
                            ? IconButton(
                                onPressed: () {
                                  showUploadPopup(context);
                                },
                                // onPressed: _showUploadPopup(context),
                                icon: Icon(Icons.add))
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 00),
                    child: Consumer<AssignmentState>(
                      builder: (context, assignmentState, child) {
                        return Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 0, 15, 00),
                          child: AssignmentAssignment(
                            focusedIndex: assignmentState.focusedIndex,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                    child: Text(
                      "Notes",
                      style: TextStyle(
                          //color: Color.fromARGB(255, 255, 255, 225),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 00),
                    child: Consumer<AssignmentState>(
                      builder: (context, assignmentState, child) {
                        return Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 0, 15, 00),
                          child: AssignmentNotes(
                            focusedIndex: assignmentState.focusedIndex,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}

class AssignmentState with ChangeNotifier {
  String _focusedIndex = '';

  String get focusedIndex => _focusedIndex;

  set focusedIndex(String newIndex) {
    _focusedIndex = newIndex;
    notifyListeners(); // Notify listeners about the change
  }
}