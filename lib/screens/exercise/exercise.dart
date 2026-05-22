import 'package:flutter/material.dart';
import 'package:pregmaa/data/exercise_data.dart';
import 'package:pregmaa/model/exercise_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<String> workoutCategories = ["beginner", "intermediate", "advanced"];

  int selectedCategory = 0;

  /// 🔥 NULL = Show All
  String? selectedTrimester;

  /// FILTER LOGIC
  List<Exercise> get filteredExercises {
    return allExercises.where((ex) {
      bool matchesLevel = ex.level == workoutCategories[selectedCategory];

      bool matchesTrimester =
          selectedTrimester == null || ex.trimester == selectedTrimester;

      return matchesLevel && matchesTrimester;
    }).toList();
  }

  /// ADD TO TASK
  Future<void> addToTask(Exercise ex) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> taskList = prefs.getStringList('tasks') ?? [];

    Map<String, dynamic> task = {
      'title': ex.name,

      'isDone': false,

      'date': DateTime.now().toIso8601String(),

      'notificationId': DateTime.now().millisecondsSinceEpoch,
    };

    taskList.add(jsonEncode(task));

    await prefs.setStringList('tasks', taskList);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Added to Daily Task ✅")));
  }

  /// OPEN YOUTUBE
  void openVideo(String url) async {
    final Uri uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise"),
        backgroundColor: Colors.amber[100],
      ),

      body: Padding(
        padding: EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// TRIMESTER FILTER
            DropdownButton<String>(
              hint: Text("Select Trimester"),

              value: selectedTrimester,

              items: ["All", "1", "2", "3"].map((t) {
                return DropdownMenuItem(
                  value: t == "All" ? null : t,

                  child: Text(t == "All" ? "All Trimester" : "Trimester $t"),
                );
              }).toList(),

              onChanged: (val) {
                setState(() {
                  selectedTrimester = val;
                });
              },
            ),

            SizedBox(height: 10),

            /// LEVEL FILTER
            ToggleButtons(
              onPressed: (index) {
                setState(() {
                  selectedCategory = index;
                });
              },

              isSelected: List.generate(
                workoutCategories.length,

                (index) => index == selectedCategory,
              ),

              children: workoutCategories.map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),

                  child: Text(e.toUpperCase()),
                );
              }).toList(),
            ),

            SizedBox(height: 15),

            /// EXERCISE LIST
            Expanded(
              child: filteredExercises.isEmpty
                  ? Center(child: Text("No exercises found"))
                  : ListView.builder(
                      itemCount: filteredExercises.length,

                      itemBuilder: (context, index) {
                        final ex = filteredExercises[index];

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Column(
                            children: [
                              /// IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),

                                child: Image.asset(
                                  ex.image,

                                  height: 150,

                                  width: double.infinity,

                                  fit: BoxFit.cover,
                                ),
                              ),

                              /// DETAILS
                              ListTile(
                                title: Text(ex.name),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      "${ex.type} • Trimester ${ex.trimester}",
                                    ),

                                    Text("Duration: ${ex.duration} min"),

                                    if (ex.doctorVerified)
                                      Text(
                                        "Doctor Verified ✅",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              /// BUTTONS
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,

                                children: [
                                  /// WATCH
                                  TextButton(
                                    onPressed: () => openVideo(ex.videoUrl),

                                    child: Text("Watch 🎥"),
                                  ),

                                  /// ADD TASK
                                  TextButton(
                                    onPressed: () => addToTask(ex),

                                    child: Text("Add Task ➕"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
