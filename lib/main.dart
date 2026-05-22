import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pregmaa/data/dummy_data.dart';
import 'package:pregmaa/model/patient_model.dart';
import 'package:pregmaa/screens/baby%20growth%20journey/screens/baby_growth_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PregMaa',
      theme: ThemeData(primarySwatch: Colors.pink),

      home: BabyGrowthScreen(),
    );
  }
}
