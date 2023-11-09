import 'package:cims/Functionality/Cache.dart';
import 'package:cims/screens/globals.dart' as globals;
import 'dart:convert';
import 'package:cims/Functionality/Cache.dart' as cache;
import 'package:cims/Model/variable.dart' as information;
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> rowDataArray = [];
List<String> userDataArray = [];

class userUniInfo {
  final String user_id;
  final String user_name;
  final String registration_number;
  final String uni_roll;

  userUniInfo(
    this.user_id,
    this.user_name,
    this.registration_number,
    this.uni_roll,
  );
}

class UserResInfo {
  final String column1;
  final String column2;
  final String column3;
  final String column4;
  final String column5;
  final String column6;
  final String column7;
  final String column8;
  final String column9;
  final String column10;
  final String column11;
  final String column12;
  final String column13;
  final String column14;
  final String column15;
  final String column16;
  final String column17;
  final String column18;

  UserResInfo({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
    required this.column5,
    required this.column6,
    required this.column7,
    required this.column8,
    required this.column9,
    required this.column10,
    required this.column11,
    required this.column12,
    required this.column13,
    required this.column14,
    required this.column15,
    required this.column16,
    required this.column17,
    required this.column18,
  });

  factory UserResInfo.fromJson(Map<String, dynamic> json) {
    return UserResInfo(
      column1: json['Column_1'],
      column2: json['Column_2'],
      column3: json['Column_3'],
      column4: json['Column_4'],
      column5: json['Column_5'],
      column6: json['Column_6'],
      column7: json['Column_7'],
      column8: json['Column_8'],
      column9: json['Column_9'],
      column10: json['Column_10'],
      column11: json['Column_11'],
      column12: json['Column_12'],
      column13: json['Column_13'],
      column14: json['Column_14'],
      column15: json['Column_15'],
      column16: json['Column_16'],
      column17: json['Column_17'],
      column18: json['Column_18'],
    );
  }
}

Future<List<userUniInfo>?> userUniDetails(String userID) async {
  String apiUrl = '${globals.ServerIP}uni_info';
// call the instance method
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_id': userID}),
    );
    print(json.encode({'user_id': userID}));
    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonArray = jsonDecode(jsonString);
      List<userUniInfo> dataList = jsonArray
          .map((data) => userUniInfo(
                data['user_id'].toString(),
                data['user_name'],
                data['registration_number'].toString(),
                data['uni_roll'].toString(),
              ))
          .toList();

      // Save the fetched data to SharedPreferences
      saveUserUniInfoToSharedPreferences(dataList);

      return dataList;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<void> saveUserUniInfoToSharedPreferences(
    List<userUniInfo> dataList) async {
  final prefs = await SharedPreferences.getInstance();

  for (var user in dataList) {
    prefs.setString('reg_no', user.registration_number);
    prefs.setString('uni_roll', user.uni_roll);
    //print('-------------------------------------' + dataList[0].toString());
  }
}

Future<(List<String>, List<String>)?> userResultDetails(String userRoll) async {
  String apiUrl = '${globals.ServerIP}res_info';
// call the instance method

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_roll': userRoll}),
    );

    if (response.statusCode == 200) {
      String jsonString = response.body;
      final jsonData = json.decode(jsonString);

      final userDataJson = jsonData['userData'] as List<dynamic>;
      final row1DataJson = jsonData['row1Data'] as List<dynamic>;

      final userDataList =
          userDataJson.map((json) => UserResInfo.fromJson(json)).toList();
      final row1DataList =
          row1DataJson.map((json) => UserResInfo.fromJson(json)).toList();
          
      userDataArray = userDataList
          .map((e) => [
                e.column2,
                e.column3,
                e.column4,
                e.column5,
                e.column6,
                e.column7,
                e.column8,
                e.column9,
                e.column10,
                e.column11,
                e.column12,
                e.column13,
                e.column14,
                e.column15,
                e.column16,
                e.column17,
                e.column18,
              ].where((value) =>
                  value.isNotEmpty)) // Filter out null and empty values
          .expand((element) => element)
          .toList();
      rowDataArray = row1DataList
          .map((userResInfo) => [
                (userDataList[0].column2!='')?userResInfo.column2:"",
                (userDataList[0].column3!='')?userResInfo.column3:"",
                (userDataList[0].column4!='')?userResInfo.column4:"",
                (userDataList[0].column5!='')?userResInfo.column5:"",
                (userDataList[0].column6!='')?userResInfo.column6:"",
                (userDataList[0].column7!='')?userResInfo.column7:"",
                (userDataList[0].column8!='')?userResInfo.column8:"",
                (userDataList[0].column9!='')?userResInfo.column9:"",
                (userDataList[0].column10!='')?userResInfo.column10:"",
                (userDataList[0].column11!='')?userResInfo.column12:"",
                (userDataList[0].column12!='')?userResInfo.column11:"",
                (userDataList[0].column13!='')?userResInfo.column13:"",
                (userDataList[0].column14!='')?userResInfo.column14:"",
                (userDataList[0].column15!='')?userResInfo.column15:"",
                (userDataList[0].column16!='')?userResInfo.column16:"",
                (userDataList[0].column17!='')?userResInfo.column17:"",
                (userDataList[0].column18!='')?userResInfo.column18:"",
                
              ].where((value) =>
                  value.isNotEmpty)) // Filter out null and empty values
          .expand((element) => element)
          .toList();

      return (userDataArray, rowDataArray);
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print(e);
    return null;
  }
}