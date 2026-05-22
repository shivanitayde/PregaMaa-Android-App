import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pregmaa/data/dummy_data.dart';
import 'package:pregmaa/model/patient_model.dart';
import 'package:pregmaa/screens/articles/article_list_screen.dart';
import 'package:pregmaa/screens/chatbot/medibot_screen.dart';
import 'package:pregmaa/screens/report_view_screen.dart';
import 'package:pregmaa/screens/user/add_doctor_screen.dart';
import 'package:pregmaa/screens/user/user_reports_screen.dart';
import 'package:pregmaa/services/doctor_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:pregmaa/screens/exercise/exercise.dart';
import 'package:pregmaa/screens/food/food.dart';
import 'package:pregmaa/screens/medicine%20remainder/medi_remainder.dart';
import 'package:pregmaa/screens/profile/profile.dart';
import 'package:pregmaa/screens/todoList/createlist.dart';
import 'package:pregmaa/model/report_model.dart';
import 'package:pregmaa/services/report_storage.dart';
import 'package:pregmaa/screens/personal%20info/u%20patient_upload_report_screen.dart';
import 'package:pregmaa/model/doctor_model.dart';
import 'package:pregmaa/services/doctor_storage.dart';
import 'package:url_launcher/url_launcher.dart';

/// ---------------- TASK MODEL ----------------
class Task {
  String title;
  bool isDone;
  DateTime? date;

  Task({required this.title, this.isDone = false, this.date});

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
    'date': date?.toIso8601String(),
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    isDone: json['isDone'],
    date: json['date'] != null ? DateTime.parse(json['date']) : null,
  );
}

/// ---------------- MEDICINE MODEL ----------------
class Medicine {
  String name;
  TimeOfDay time;
  DateTime endDate;
  bool isTaken;

  Medicine({
    required this.name,
    required this.time,
    required this.endDate,
    required this.isTaken,
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

class Home extends StatefulWidget {
  final Patient patient;
  const Home({super.key, required this.patient});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = [];
  List<Medicine> medicines = [];
  List<Report> reports = [];
  Doctor? doctor;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadMedicines(); // 🔥 NEW
    _loadDoctor();
    _loadReports();
  }

  /// ---------------- LOAD TASKS ----------------

  Future<void> _loadReports() async {
    reports = await ReportStorage.loadReports();

    setState(() {});
  }

  /// LOAD DOCTOR
  Future<void> _loadDoctor() async {
    doctor = await DoctorStorage.loadDoctor();
    setState(() {});
  }

  /// CALL DOCTOR
  Future<void> _callDoctor(String phone) async {
    final Uri callUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Cannot make call")));
    }
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      setState(() {
        tasks = taskList.map((e) {
          try {
            return Task.fromJson(jsonDecode(e));
          } catch (_) {
            return Task(title: e);
          }
        }).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('tasks', taskList);
  }

  /// ---------------- LOAD MEDICINES ----------------
  Future<void> _loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("medicines");

    if (data != null) {
      setState(() {
        medicines = data.map((e) => Medicine.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  Future<void> _saveMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = medicines.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList("medicines", data);
  }

  /// ---------------- FILTERS ----------------
  List<Task> get todayTasks {
    final now = DateTime.now();

    return tasks.where((task) {
      if (task.date == null) return false;

      return task.date!.year == now.year &&
          task.date!.month == now.month &&
          task.date!.day == now.day;
    }).toList();
  }

  List<Medicine> get todayMedicines {
    final now = DateTime.now();

    return medicines.where((med) {
      return now.isBefore(med.endDate.add(Duration(days: 1)));
    }).toList();
  }

  /// ---------------- PROGRESS ----------------
  double get progress {
    int total = todayTasks.length + todayMedicines.length;
    if (total == 0) return 0;

    int completed =
        todayTasks.where((t) => t.isDone).length +
        todayMedicines.where((m) => m.isTaken).length;

    return completed / total;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Map<String, double> dataMap = {
      "Completed": progress,
      "Remaining": 1 - progress,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: Text("Hii, User"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MediBotScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(Icons.chat_bubble_outline),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserReportsScreen(
                    patient: widget.patient, // ✅ FIXED
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(Icons.folder, color: Colors.amber),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddDoctorScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(Icons.local_hospital, color: Colors.blue),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// DOCTOR SECTION
            if (doctor == null)
              Padding(
                padding: EdgeInsets.all(10),

                child: ElevatedButton.icon(
                  icon: Icon(Icons.local_hospital),

                  label: Text("Add Your Doctor"),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddDoctorScreen()),
                    ).then((_) {
                      _loadDoctor();
                    });
                  },
                ),
              )
            else
              Padding(
                padding: EdgeInsets.all(10),

                child: Container(
                  padding: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    children: [
                      /// Doctor Image
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddDoctorScreen(doctor: doctor),
                            ),
                          ).then((_) {
                            _loadDoctor();
                          });
                        },

                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(doctor!.image),
                        ),
                      ),

                      SizedBox(width: 12),

                      /// Doctor Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Your Doctor",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            Text(doctor!.name, style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),

                      /// CALL BUTTON
                      IconButton(
                        icon: Icon(Icons.call, color: Colors.green),

                        onPressed: () {
                          if (doctor != null && doctor!.contact.isNotEmpty) {
                            _callDoctor(doctor!.contact);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

            /// SERVICES
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Services", style: TextStyle(fontSize: 20)),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ExercisePage()),
                      );
                    },
                    child: services(
                      image: AssetImage('assets/images/exercise.jpg'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FoodRecommendation()),
                      );
                    },
                    child: services(
                      image: AssetImage('assets/images/food.jpg'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MediRemainder()),
                      ).then((_) => _loadMedicines()); // 🔥 REFRESH
                    },
                    child: services(
                      image: AssetImage('assets/images/medicine.jpg'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ArticleListScreen()),
                      ).then((_) => _loadMedicines()); // 🔥 REFRESH
                    },
                    child: services(
                      image: AssetImage('assets/images/medicine.jpg'),
                    ),
                  ),
                ],
              ),
            ),

            /// 📄 REPORT SECTION

            /// TODAY TASKS
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's Tasks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            if (todayTasks.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("No tasks for today 😄"),
              ),

            ...todayTasks.map((task) {
              return GestureDetector(
                onLongPress: () {
                  setState(() {
                    tasks.remove(task);
                  });
                  _saveTasks();
                },
                child: TaskNote(
                  text: task.title,
                  isChecked: task.isDone,
                  onChanged: (val) {
                    setState(() {
                      task.isDone = val!;
                    });
                    _saveTasks();
                  },
                ),
              );
            }),

            /// 💊 TODAY MEDICINES
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's Medicines",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            if (todayMedicines.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("No medicines for today 💊"),
              ),

            ...todayMedicines.map((med) {
              return TaskNote(
                text: "${med.name} (${med.time.format(context)})",
                isChecked: med.isTaken,
                onChanged: (val) {
                  setState(() {
                    med.isTaken = val!;
                  });
                  _saveMedicines();
                },
              );
            }),

            /// PROGRESS
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Progress",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Center(
              child: PieChart(dataMap: dataMap, chartRadius: size.width / 2.5),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TodoList()),
                ).then((_) => _loadTasks());
              },
              child: Icon(Icons.list),
            ),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Profilepage()),
                );
              },
              child: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// SERVICE CARD
class services extends StatelessWidget {
  final AssetImage image;

  const services({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.15,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// TASK CARD
class TaskNote extends StatelessWidget {
  final String text;
  final bool isChecked;
  final Function(bool?) onChanged;

  const TaskNote({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          Checkbox(value: isChecked, onChanged: onChanged),
        ],
      ),
    );
  }
}
