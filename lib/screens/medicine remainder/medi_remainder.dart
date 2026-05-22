import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MediRemainder extends StatefulWidget {
  const MediRemainder({super.key});

  @override
  State<MediRemainder> createState() => _MediRemainderState();
}

// MODEL
class Medicine {
  String name;
  TimeOfDay time;
  DateTime endDate;
  bool isTaken;

  Medicine({
    required this.name,
    required this.time,
    required this.endDate,
    this.isTaken = false,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    List<String> timeParts = json['time'].split(":");

    return Medicine(
      name: json['name'],
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      endDate: DateTime.parse(json['endDate']),
      isTaken: json['isTaken'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "time": "${time.hour}:${time.minute}",
    "endDate": endDate.toIso8601String(),
    "isTaken": isTaken,
  };
}

class _MediRemainderState extends State<MediRemainder> {
  List<Medicine> medicines = [];

  final TextEditingController nameController = TextEditingController();

  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    initNotifications();
    loadMedicines();
  }

  // 🔥 LOAD
  Future<void> loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("medicines");

    if (data != null) {
      setState(() {
        medicines = data.map((e) => Medicine.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  // 🔥 SAVE
  Future<void> saveMedicines() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = medicines.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList("medicines", data);
  }

  Future<void> initNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(settings);

    tz.initializeTimeZones(); // 🔥 MUST
  }

  // 🔔 NOTIFICATION FUNCTION (FINAL WORKING)
  Future<void> scheduleNotification(Medicine med) async {
    final now = DateTime.now();

    final scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      med.time.hour,
      med.time.minute,
    );

    final tzScheduled = tz.TZDateTime.from(scheduled, tz.local);

    print("🔔 Scheduling at: $tzScheduled");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      med.hashCode,
      "Medicine Reminder 💊",
      "Take ${med.name}",
      tzScheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'final_channel_1',
          'Medicine',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound('alarm'),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    if (tzScheduled.isBefore(tz.TZDateTime.now(tz.local))) {
      print("⚠️ Time already passed");
      return;
    }
  }

  // ADD / EDIT
  void openMedicineDialog({Medicine? med, int? index}) {
    if (med != null) {
      nameController.text = med.name;
      selectedTime = med.time;
      selectedDate = med.endDate;
    } else {
      nameController.clear();
      selectedTime = null;
      selectedDate = null;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(med == null ? "Add Medicine" : "Edit Medicine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Medicine Name"),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() => selectedTime = picked);
                  }
                },
                child: Text(
                  selectedTime == null
                      ? "Select Time"
                      : selectedTime!.format(context),
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
                child: Text(
                  selectedDate == null
                      ? "Select End Date"
                      : selectedDate.toString().split(" ")[0],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    selectedTime == null ||
                    selectedDate == null)
                  return;

                Medicine newMed = Medicine(
                  name: nameController.text,
                  time: selectedTime!,
                  endDate: selectedDate!,
                );

                setState(() {
                  if (med == null) {
                    medicines.add(newMed);
                    scheduleNotification(newMed);
                  } else {
                    medicines[index!] = newMed;
                    scheduleNotification(newMed);
                  }
                });

                saveMedicines();
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  String formatTime(TimeOfDay time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  bool isTodayValid(DateTime endDate) {
    return DateTime.now().isBefore(endDate.add(Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: 30),
          ),
          SizedBox(width: size.width * 0.67),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.menu, size: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.chat),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: medicines.isEmpty
            ? Center(child: Text("No Medicines Added"))
            : ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final med = medicines[index];

                  if (!isTodayValid(med.endDate)) return SizedBox();

                  return Column(
                    children: [
                      MedicineRemainder(
                        text: med.name,
                        time: formatTime(med.time),
                        isTaken: med.isTaken,
                        onCheck: (val) {
                          setState(() => med.isTaken = val!);
                          saveMedicines();
                        },
                        onDelete: () {
                          setState(() => medicines.removeAt(index));
                          saveMedicines();
                        },
                        onEdit: () {
                          openMedicineDialog(med: med, index: index);
                        },
                        onResetTime: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: med.time,
                          );
                          if (picked != null) {
                            setState(() => med.time = picked);
                            scheduleNotification(med);
                            saveMedicines();
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  );
                },
              ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[300],
        onPressed: () {
          openMedicineDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// UI CARD
class MedicineRemainder extends StatelessWidget {
  final String text;
  final String time;
  final bool isTaken;
  final Function(bool?) onCheck;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onResetTime;

  const MedicineRemainder({
    super.key,
    required this.text,
    required this.time,
    required this.isTaken,
    required this.onCheck,
    required this.onDelete,
    required this.onEdit,
    required this.onResetTime,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.12,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Checkbox(value: isTaken, onChanged: onCheck),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(text), Text(time)],
          ),
          IconButton(icon: Icon(Icons.alarm), onPressed: onResetTime),
          IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
