import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar_green(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: const Text('snack'),
    duration: const Duration(seconds: 1),
    action: SnackBarAction(
      label: 'ACTION',
      onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar;
      },
    ),
  ));
  static void showSnackBar_red(BuildContext context, String message) =>
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: const Text('snack'),
    duration: const Duration(seconds: 1),
    action: SnackBarAction(
      label: 'ACTION',
      onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar;
      },
    ),
  ));
      
}
