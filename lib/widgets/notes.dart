import 'package:cims/widgets/TaskViewer.dart';
import 'package:flutter/material.dart';
import 'package:cims/Functionality/notesmanager.dart' as notesmanager;

class AssignmentNotes extends StatefulWidget {
  String focusedIndex;
  AssignmentNotes({super.key, required this.focusedIndex});

  @override
  State<AssignmentNotes> createState() => _AssignmentNotesState();
}

class _AssignmentNotesState extends State<AssignmentNotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5.5),
      height: 300,
      width: 1200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '7/7',
            ),
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '3/7',
            ),
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '5/7',
            ),
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '4/7',
            ),
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '8/7',
            ),
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '9/11',
            ),
            TaskViewer(
              item: "Notes" + widget.focusedIndex.toString(),
              date: '1/7',
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentAssignment extends StatefulWidget {
  String focusedIndex;
  AssignmentAssignment({super.key, required this.focusedIndex});

  @override
  State<AssignmentAssignment> createState() => _AssignmentAssignmentState();
}

class _AssignmentAssignmentState extends State<AssignmentAssignment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 300,
      width: 1200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding: EdgeInsetsDirectional.all(8),
        child: ListView(
          children: [
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '3/7',
            ),
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '3/7',
            ),
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '5/7',
            ),
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '4/7',
            ),
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '8/7',
            ),
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '11/17',
            ),
            TaskViewer(
              item: "Task " + widget.focusedIndex.toString(),
              date: '1/7',
            ),
          ],
        ),
      ),
    );
  }
}