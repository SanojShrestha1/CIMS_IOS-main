import 'dart:math';
import 'package:cims/Functionality/notesmanager.dart' as notesmanager;
import 'package:cims/APIs/APIsubject.dart';
import 'package:cims/Screens/Assignment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:cims/APIs/APIroutine.dart';

class MYimproSlider extends StatefulWidget {
  int focusedIndex;

  MYimproSlider({Key? key, required this.focusedIndex}) : super(key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<MYimproSlider> {
  List<int> data = [];
  List<SubjectInfo> subjectDataList = [];
  //int _focusedIndex = 0;
  int _valueToPass = 1; // Variable to store the value to pass
  int i = 0;

  @override
  void initState() {
    super.initState();
    fetchSubjectFromServer();
  }

  Future<void> fetchSubjectFromServer() async {
    try {
      final List<SubjectInfo> fetchedSubjectData = await fetchSubjectData();
      print('fetchedData length:🔥🔥🔥 ${fetchedSubjectData.length}');

      if (mounted) {
        setState(() {
          subjectDataList = fetchedSubjectData;
          data = List.generate(
              fetchedSubjectData.length, (index) => Random().nextInt(100) + 1);
        });
      }
    } catch (error) {
      print('Error fetching data😒: $error');
    }
  }

  void _onItemFocus(int index) {
    //widget.focusedIndex = index;
    _valueToPass = index; // Set the value
    print(_valueToPass);
    final assignmentState =
        Provider.of<AssignmentState>(context, listen: false);
    assignmentState.focusedIndex = subjectDataList[index].sub_code;

    // Future.delayed(Duration.zero, () {
    //   _navigateToAnotherPage(index, subjectDataList[index].sub_code);
    // });
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == subjectDataList.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      child: Container(
        width: 260,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  radius: 0.8,
                  colors: [
                    Color.fromARGB(255, 143, 21, 12),
                    Color.fromARGB(255, 112, 27, 22),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              height: 130,
              width: 241,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    subjectDataList[index].sub_name,
                    style: TextStyle(
                      color: Color.fromARGB(128, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    subjectDataList[index].sub_code,
                    style: TextStyle(
                      color: Color.fromARGB(128, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Credit: ${subjectDataList[index].sub_credit}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromARGB(128, 255, 255, 225),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                  //   child: Text(
                  //     "Tap here to view more",
                  //     style: TextStyle(
                  //       color: Color.fromARGB(225, 0, 0, 0),
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 10,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToAnotherPage(index, classname) {
    setState(() {
      notesmanager.index = index;
      notesmanager.className = classname;
      print("change garepachi" + notesmanager.className);
    });
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Assignment(
    //               Classname: notesmanager.className,
    //               focuseditem: notesmanager.index,
    //             )));
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the initial index to make the item in the center focused
    try {
      int initialindex =
          (subjectDataList.length ~/ 2).clamp(0, subjectDataList.length - 1);

      return Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ScrollSnapList(
                // ... Other properties ...
                initialIndex: widget.focusedIndex
                    .toDouble(), // Set the initial focused index to the calculated value
                onItemFocus: _onItemFocus,
                itemSize: 260,
                duration: 200,
                itemBuilder: _buildListItem,
                itemCount: subjectDataList.length,
                dynamicItemSize: true,
                // scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return Container();
    }
  }
}