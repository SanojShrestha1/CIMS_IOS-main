import 'dart:async';
import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Model/variable.dart' as information;
import 'package:cims/Screens/Home.dart';
import 'package:cims/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String KEYLOGIN = "KEYLOGIN";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  //static const String KEYLOGIN = "NONOOOONOOOONOOO";

  @override
  void initState() {
    super.initState();
    wheretogo();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Set the animation duration
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    // After the animation completes, navigate to the main screen
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 0, 0, 0), // Choose your background color
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: child,
            );
          },
          child: Text(
            '😎',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void wheretogo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(SplashScreen.KEYLOGIN);
    
    Timer(Duration(seconds: 2), () async {
      try {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(ID: UserProvider().userId),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ButtonStates(),
              ),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ButtonStates(),
            ),
          );
        }
      } catch (e) {
        // Handle any errors that may occur during token retrieval
        print('Error fetching token: $e');
        // Assuming there's an error, navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ButtonStates(),
          ),
        );
      }
    });
  }
}