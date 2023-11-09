import 'package:cims/widgets/SubmitButton.dart';
import 'package:flutter/material.dart';

class TaskViewer extends StatefulWidget {
  final String item;

  final String date;
  const TaskViewer({super.key, required this.item, required this.date});

  @override

  // ignore: library_private_types_in_public_api
  TaskViewerState createState() => TaskViewerState();
}

class TaskViewerState extends State<TaskViewer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 9, 15),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //const Padding(padding: EdgeInsets.all(10)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.item,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 225),
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ]),
              //const Padding(padding: EdgeInsets.fromLTRB(20, 15, 0, 0)),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      //child: MYSlider(),
                      height: 35,
                      width: 220,
                      //color: Color.fromARGB(255, 218, 205, 207),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                        height: 10,
                        width: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color.fromARGB(255, 127, 24, 32),
                        ),
                        child: SubmitButton(),
                      ),
                    ),
                  ]),
              Padding(
                padding: EdgeInsets.fromLTRB(2, 15, 0, 0),
                child: Text(
                  widget.date,
                  style: const TextStyle(
                      color: Color.fromARGB(123, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ),
            ],
          ),
        ));
  }
}