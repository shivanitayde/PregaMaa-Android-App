import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pregmaa/data/dummy_data.dart';
import 'package:pregmaa/model/patient_model.dart';
import 'package:pregmaa/screens/articles/article_list_screen.dart';
import 'package:pregmaa/screens/baby%20growth%20journey/screens/baby_growth_screen.dart';
import 'package:pregmaa/screens/chatbot/medibot_screen.dart';
import 'package:pregmaa/screens/doctor%20dashboard/doctor_dashboard.dart';
import 'package:pregmaa/screens/doctor%20dashboard/doctor_login_screen.dart';
import 'package:pregmaa/screens/home/home.dart';
import 'package:pregmaa/screens/login/login.dart';
import 'package:pregmaa/screens/personal%20info/personal_info_screen.dart';
import 'package:pregmaa/screens/user/user_reports_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(settings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();

  runApp(MyApp(patient: patients[0]));
}

class MyApp extends StatelessWidget {
  final Patient patient;
  const MyApp({super.key, required this.patient});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BabyGrowthScreen(),
    );
  }
}
