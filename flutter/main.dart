import 'package:flutter/material.dart';
import 'package:asthma/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
// ignore: unused_import
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the local notifications plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  tz.initializeTimeZones(); // Initialize time zones

  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Medication {
  final String name;
  final double dosage;
  final TimeOfDay time;
  final DateTime date;

  Medication(
      {required this.name,
      required this.dosage,
      required this.time,
      required this.date});
}

class Reading {
  String date;
  int reading;

  Reading(this.date, this.reading);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
