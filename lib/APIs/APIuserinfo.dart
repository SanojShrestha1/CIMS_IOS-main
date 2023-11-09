import 'package:cims/Functionality/Cache.dart';
import 'package:cims/screens/globals.dart' as globals;
import 'dart:convert';
import 'package:cims/Functionality/Cache.dart' as cache;
import 'package:cims/Model/variable.dart' as information;
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Custom class to hold S_Code, S_sub_name, and S_sub_credit
class userInfo {
  final String user_id;
  final String user_name;
  final String user_year;
  final String user_class;
  final String user_email;
  final String profile_pic;
  final String user_address;
  final String user_phone;
  final String user_role;

  userInfo(
      this.user_id,
      this.user_name,
      this.user_year,
      this.user_email,
      this.user_class,
      this.profile_pic,
      this.user_address,
      this.user_phone,
      this.user_role);
}

class uniInfo {
  final String uni_roll;
  final String user_name;
  final String registration_number;

  uniInfo(
    this.uni_roll,
    this.user_name,
    this.registration_number,
  );
}

Future<List<uniInfo>?> uni_Details(String userID) async {
  String apiUrl = '${globals.ServerIP}uni_info';
// call the instance method

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_id': userID}),
    );

    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonArray = jsonDecode(jsonString);
      List<uniInfo> unidataList = jsonArray
          .map((data) => uniInfo(
                data['uni_roll'].toString(),
                data['user_name'],
                data['registration_number'].toString(),
              ))
          .toList();
      // Save the fetched data to SharedPreferences
      saveUniInfoToSharedPreferences(unidataList);

      return unidataList;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<List<userInfo>?> userDetails(String userID) async {
  String apiUrl = '${globals.ServerIP}details';
// call the instance method

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_id': userID}),
    );

    if (response.statusCode == 200) {
      String jsonString = response.body;
      List<dynamic> jsonArray = jsonDecode(jsonString);
      List<userInfo> dataList = jsonArray
          .map((data) => userInfo(
                data['user_id'].toString(),
                data['user_name'],
                data['user_year'].toString(),
                data['user_email'],
                data['user_class'],
                data['profile_pic'],
                data['user_address'],
                data['user_phone'].toString(),
                data['role'],
              ))
          .toList();

      // Save the fetched data to SharedPreferences
      saveUserInfoToSharedPreferences(dataList);

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

Future<void> saveUserInfoToSharedPreferences(List<userInfo> dataList) async {
  final prefs = await SharedPreferences.getInstance();

  for (var user in dataList) {
// Using user ID as part of the key
    // print("😎😎😎" + user.profile_pic);
    prefs.setString('id', user.user_id);
    prefs.setString('name', user.user_name);
    prefs.setString('year', user.user_year);
    prefs.setString('profile_pic', user.profile_pic);
    prefs.setString('address', user.user_address);
    prefs.setString('class', user.user_class);
    prefs.setString('email', user.user_email);
    prefs.setString('phone', user.user_phone);
    prefs.setString('role', user.user_role);
    // var profilePic = prefs.getString('profile_pic') ?? '';
    // print("🤣🤣🤣🤣 Profile Pic: " + profilePic);
    // var userName = prefs.getString('role') ?? '';
    // print("🤣🤣🤣🤣 Profile Pic: " + userName);
  }
}

Future<void> saveUniInfoToSharedPreferences(List<uniInfo> dataList) async {
  final prefs = await SharedPreferences.getInstance();

  for (var user in dataList) {
// Using user ID as part of the key
    // print("😎😎😎" + user.profile_pic);
    prefs.setString('uni_roll', user.uni_roll);
    prefs.setString('name', user.user_name);
    prefs.setString('reg_no', user.registration_number);

    // var profilePic = prefs.getString('profile_pic') ?? '';
    // print("🤣🤣🤣🤣 Profile Pic: " + profilePic);
    // var userName = prefs.getString('role') ?? '';
    // print("🤣🤣🤣🤣 Profile Pic: " + userName);
  }
}