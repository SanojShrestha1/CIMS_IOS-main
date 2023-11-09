import 'package:flutter/material.dart';

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
    String status = widget.Time;
    // Get the current system time
    DateTime currentTime = DateTime.now();

    // Extract the current hour as an integer
    int currentHour = currentTime.hour;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 127, 24, 32),
            ),
            child: Text(
              widget.box,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          const Padding(padding: EdgeInsets.all(6)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //color: Colors.amber,
                  height: 23,
                  width: 240,
                  child: Text(
                    widget.Subject,
                    style: TextStyle(
                        //color: Color.fromARGB(255, 255, 255, 225),
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                Text(
                  widget.Teacher,
                  style: TextStyle(
                      color: Color.fromARGB(123, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ]),
          const Padding(padding: EdgeInsets.fromLTRB(15, 15, 0, 0)),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
            Text(
              "  ",
            ),
            currentHour <= 18
                ? status == "Completed"
                    ? Text(
                        widget.Time,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 30, 89, 152),
                            fontWeight: FontWeight.bold,
                            fontSize: 9),
                      )
                    : status == "Ongoing"
                        ? Text(
                            widget.Time,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 9),
                          )
                        : Text(
                            widget.Time,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 9),
                          )
                : Text(
                    "Tomorrow",
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

class NOTClassViewer extends StatefulWidget {
  ///const ClassViewer({super.key});
  final String Teacher;
  final String Subject;
  final String Time;
  final String box;

  const NOTClassViewer({
    super.key,
    required this.Teacher,
    required this.Subject,
    required this.Time,
    required this.box,
  });
  @override
  // ignore: library_private_types_in_public_api
  NOTClassViewerState createState() => NOTClassViewerState();
}

class NOTClassViewerState extends State<NOTClassViewer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 127, 24, 32),
            ),
            child: Text(
              widget.box,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.Subject,
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                Text(
                  widget.Teacher,
                  style: TextStyle(
                      color: Color.fromARGB(123, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ]),
          const Padding(padding: EdgeInsets.fromLTRB(80, 15, 0, 0)),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "               ",
                ),
                Text(
                  widget.Time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 249, 162, 32),
                      fontWeight: FontWeight.bold,
                      fontSize: 9),
                ),
              ]),
        ],
      ),
    );
  }
}