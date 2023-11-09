import 'dart:convert';
import 'package:cims/screens/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Custom class to hold teacher, subject, and time
class TeacherRoutineData {
  final String classroom;
  final String subject;
  final String time;

  TeacherRoutineData(this.classroom, this.subject, this.time);
}
// teacher--subject
// + Options
// semester
// day
// time
// teacher
// subject
// classroom

Future<List<TeacherRoutineData>> fetchteacherDataToday() async {
  // Get the current system time
  DateTime currentTime = DateTime.now();

  // Extract the current hour as an integer
  int currentHour = currentTime.hour;
  if (currentHour >= 18) {
    final response = await http.post(
      (Uri.parse('${globals.ServerIP}teacher_routine_tomorrow')),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': '"Chiranjibi Pandey"'
      }), //this must be replace to make it dynamic
    );
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonArray = jsonDecode(jsonString);
      List<TeacherRoutineData> dataList = jsonArray
          .map((data) => TeacherRoutineData(
                data['classroom'],
                data['subject'],
                data['time'],
              ))
          .toList();

      print('Fetched data length:👌 ${dataList.length}');

      return dataList;
    } else {
      print('Failed to fetch data. Error code: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } else {
    final response = await http.post(
      (Uri.parse('${globals.ServerIP}teacher_routine_today')),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': '"Chiranjibi Pandey"'}),
    );
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonArray = jsonDecode(jsonString);
      List<TeacherRoutineData> dataList = jsonArray
          .map((data) => TeacherRoutineData(
                data['classroom'],
                data['subject'],
                data['time'],
              ))
          .toList();

      print('Fetched data length:👌 ${dataList.length}');

      return dataList;
    } else {
      print('Failed to fetch data. Error code:${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  }
}