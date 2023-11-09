import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String userId = '';
  String userName = '';
  String userYear = '';
  String userClass = '';
  String userEmail = '';
  String profilePic = '';
  String userAddress = '';
  String userPhone = '';
  String userRole = '';
  // Add other user properties here
  String sub_code = '';
  String sub_name = '';
  String userRoll = '';
  String userReg = '';
  int sub_credit = 0;
  // Load user info from SharedPreferences
  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id') ?? '';
    userName = prefs.getString('name') ?? '';
    userYear = prefs.getString('year') ?? '';
    userClass = prefs.getString('class') ?? '';
    userEmail = prefs.getString('email') ?? '';
    profilePic = prefs.getString('profile_pic') ?? '';
    userAddress = prefs.getString('address') ?? '';
    userPhone = prefs.getString('phone') ?? '';
    userRole = prefs.getString('role') ?? '';
    userRoll = prefs.getString('uni_roll') ?? '';
    userReg = prefs.getString('reg_no') ?? '';
    //print("🤣🤣🤣🤣 " + userAddress);
    notifyListeners();
  }

  Future<void> loadSubjectInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('sub_code') ?? '';
    userName = prefs.getString('sub_name') ?? '';
    userYear = prefs.getString('credit_hour') ?? '';
    // userClass = prefs.getString('class') ?? '';
    // userEmail = prefs.getString('email') ?? '';
    // profilePic = prefs.getString('profile_pic') ?? '';
    // userAddress = prefs.getString('address') ?? '';
    // userPhone = prefs.getString('phone') ?? '';
    // userRole = prefs.getString('role') ?? '';
    // //print("🤣🤣🤣🤣 " + userAddress);
    notifyListeners();
  }
}