import 'dart:convert';
import 'package:cims/Screens/globals.dart' as globals;
import 'package:cims/Screens/globals.dart';

import 'package:http/http.dart' as http;
import 'APIroutine.dart';

// Custom class to hold S_Code, S_sub_name, and S_sub_credit
class SubjectInfo {
  final String sub_code;
  final String sub_name;
  final int sub_credit;

  SubjectInfo(this.sub_code, this.sub_name, this.sub_credit);
}

Future<List<SubjectInfo>> fetchSubjectData() async {
  final timeoutDuration =
      Duration(seconds: 5); // Adjust the timeout duration as needed

  try {
    final response = await http
        .get(Uri.parse('${globals.ServerIP}subject'))
        .timeout(timeoutDuration);
    //print("Subject ko maal ho yo${response.statusCode}");
    if (response.statusCode == 200) {
      ServerConnection = true;
      // String jsonString = response.body;
      // await saveJsonToInternalStorage("Subjectdata.json", jsonString);
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print(e);
  }

  var stringlist = await readJsonFromInternalStorage("Subjectdata.json");
  print(stringlist);
  List<dynamic> jsonArray = jsonDecode(stringlist!);
  List<SubjectInfo> dataList = jsonArray
      .map((data) => SubjectInfo(
            data['sub_code'],
            data['sub_name'],
            data['credit_hour'],
          ))
      .toList();
  print('Save vako subject data: ${dataList.length}');
  return dataList;
 }