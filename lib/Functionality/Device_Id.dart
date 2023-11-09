import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

void schedulePeriodicNotifications(data, title) async {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Configure Android notification settings
var initializationSettingsAndroid =
    AndroidInitializationSettings('x'); // Replace with your icon name
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    //iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create the notification details
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
  //var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    //iOS: iOSPlatformChannelSpecifics,
  );

  // Schedule the periodic notifications (every 2 minutes)

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    data,
    platformChannelSpecifics,
    payload: data, // Set the payload to the message
  );
}