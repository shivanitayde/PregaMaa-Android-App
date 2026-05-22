import 'package:flutter/material.dart';
import 'package:pregmaa/screens/baby%20growth%20journey/data/pregnancy_week.dart';

import '../models/week_model.dart';
import '../widgets/baby_model_viewer.dart';

class BabyGrowthScreen extends StatefulWidget {
  const BabyGrowthScreen({super.key});

  @override
  State<BabyGrowthScreen> createState() => _BabyGrowthScreenState();
}

class _BabyGrowthScreenState extends State<BabyGrowthScreen> {
  int currentWeek = 20;

  @override
  Widget build(BuildContext context) {
    final weekData = WeekModel.fromMap(
      pregnancyWeeks.firstWhere((e) => e['week'] == currentWeek),
    );

    return Scaffold(
      backgroundColor: Colors.pink.shade50,

      appBar: AppBar(
        title: const Text("Baby Growth Journey"),
        backgroundColor: Colors.pink,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Text(
              "Week ${weekData.week}",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Slider(
              value: currentWeek.toDouble(),
              min: 20,
              max: 21,
              divisions: 1,
              activeColor: Colors.pink,

              onChanged: (value) {
                setState(() {
                  currentWeek = value.toInt();
                });
              },
            ),

            const SizedBox(height: 20),

            BabyModelViewer(modelUrl: weekData.model),

            const SizedBox(height: 20),

            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    Text(
                      "Baby Size: ${weekData.babySize}",
                      style: const TextStyle(fontSize: 22),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Weight: ${weekData.weight}",
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Length: ${weekData.length}",
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      weekData.development,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
