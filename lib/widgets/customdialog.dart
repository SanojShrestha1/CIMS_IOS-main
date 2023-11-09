import 'dart:ui';
import 'package:cims/Screens/Home.dart';
import 'package:cims/widgets/custom_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _timeController = TextEditingController();
final _classroomController = TextEditingController();
dynamic showUploadPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 180,
                width: 310,
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.difference,
                  borderRadius: BorderRadius.circular(30.0),
                  //backgroundBlendMode: BlendMode.colorBurn,
                  color: const Color.fromARGB(77, 97, 97, 97),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.all(10),
                      child: Text(
                        'Upload File',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.all(10),
                      child: Text(
                        'Select a file to upload',
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(130, 80, 10, 0)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text('Cancel',
                              style: TextStyle(
                                color: Colors.white24,
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform the upload logic here
                            Navigator.pop(dialogContext); // Close the dialog
                          },
                          child: Text('Upload',
                              style: TextStyle(color: Colors.amber)),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      );
    },
  );
}

Future<TimeOfDay?> showCustomTimePicker(
    {TimeOfDay? initialTime, required BuildContext context}) async {
  final now = DateTime.now();
  final initialTimeOfDay =
      initialTime ?? TimeOfDay(hour: now.hour, minute: now.minute);

  return await showTimePicker(
    context: context,
    initialTime: initialTimeOfDay,
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(alwaysUse24HourFormat: false), // Use 12-hour format
        child: child!,
      );
    },
  );
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final time =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  // Format the time using intl package
  final formattedTime = DateFormat.jm().format(time);

  return formattedTime;
}

dynamic showEditPopup(BuildContext context, teacher, classroom, time) {
  // Function to handle the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showCustomTimePicker(context: context
        //initialTime: TimeOfDay.now(), // You can set the initial time here
        );

    if (pickedTime != null) {
      String formattedTime = formatTimeOfDay(pickedTime);
//final selectedTime = "${formattedTime.hour}:${pickedTime.minute}";
      // Set the selected time in the _timeController
      _timeController.text = formattedTime;
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 280,
              width: 450,
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.difference,
                borderRadius: BorderRadius.circular(30.0),
                color: const Color.fromARGB(77, 97, 97, 97),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.all(5),
                      child: Text(
                        'Edit your class',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomFormField(
                      headingText: "Time",
                      hintText: time,
                      obsecureText: false,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.watch_later_outlined),
                        onPressed: () {
                          // Open the time picker
                          _selectTime(context);
                        },
                      ),
                      textInputType: TextInputType.datetime,
                      textInputAction: TextInputAction.done,
                      controller: _timeController,
                      maxLines: 1,
                      isEmpty: true,
                    ),
                    CustomFormField(
                      headingText: "Classroom",
                      hintText: classroom,
                      obsecureText: false,
                      suffixIcon: Icon(Icons.room_outlined),
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      controller: _classroomController,
                      maxLines: 1,
                      isEmpty: true,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(80, 80, 0, 0)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text('Cancel',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white24,
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform the upload logic here
                            Navigator.pop(dialogContext); // Close the dialog
                          },
                          child: Text('Remove',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform the upload logic here
                            Navigator.pop(dialogContext); // Close the dialog
                          },
                          child: Text('Update',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.amber)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}