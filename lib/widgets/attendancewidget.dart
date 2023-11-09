import 'package:flutter/material.dart';
import 'package:cims/Screens/globals.dart' as globals;

class ClassViewer extends StatefulWidget {
  ///const ClassViewer({super.key});
  final String Teacher;
  final String Subject;
  final String Time;
  final String box;

  const ClassViewer({
    super.key,
    required this.Teacher,
    required this.Subject,
    required this.Time,
    required this.box,
  });
  @override
  // ignore: library_private_types_in_public_api
  ClassViewerState createState() => ClassViewerState();
}

class ClassViewerState extends State<ClassViewer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.5),
            child: CircleAvatar(
              backgroundColor: globals.colour,
              radius: 23,
              child: GestureDetector(
                onTap: (() {
                  {}
                  ;
                }),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.box),
                  radius: 20,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.Subject,
                  style: TextStyle(
                      //color: Color.fromARGB(255, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                Text(
                  widget.Teacher,
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ]),
          const Padding(padding: EdgeInsets.fromLTRB(20, 15, 0, 0)),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            Text(
              "  ",
            ),
            Text(
              widget.Time,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 9),
            ),
          ]),
        ],
      ),
    );
  }
}