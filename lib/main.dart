import 'dart:async';

import 'package:cims/Functionality/Cache.dart';
import 'package:cims/Screens/Assignment.dart';
import 'package:cims/Screens/splashscreen.dart';
import 'package:cims/screens/Login.dart';
import 'package:cims/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/globals.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Your UserProvider
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AssignmentState()), // Add this line
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CIMS',
      themeMode: ThemeMode.system,
      theme: globals.ThemeClass.lightTheme,
      darkTheme: globals.ThemeClass.darkTheme,
      home: SplashScreen(),
      //  routes: {
      //     '/main': (context) =>ButtonStates(), // Add your main screen here
      //   },
    );
  }
}