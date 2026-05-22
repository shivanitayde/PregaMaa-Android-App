import 'package:flutter/painting.dart';
import 'package:pregmaa/model/patient_model.dart';
import 'package:pregmaa/model/slot_model.dart';

import '../model/report_model.dart';
import '../model/doctor_model.dart';

List<Patient> patients = [
  Patient(
    id: "p1",
    name: "Anjali Patil",
    image: "assets/p1.jpg",
    phone: "9876543211",

    age: 26,
    trimester: "2nd Trimester",
    notes: "Healthy pregnancy",

    bloodGroup: "O+",
    height: 160,
    weight: 62,
    hemoglobin: 11.2,
    platelets: 2.5,

    reports: [
      Report(
        id: "r1",
        title: "Blood Test Report",
        fileUrl: "assets/reports/sample_blood_report.pdf",
        fileType: "pdf",
        date: "10 April 2026",
        doctorSuggestion: "Hemoglobin slightly low",
      ),

      Report(
        id: "r2",
        title: "Ultrasound Report",
        fileUrl: "assets/reports/ultrasound.jpg",
        fileType: "image",
        date: "15 April 2026",
        doctorSuggestion: "Baby growth normal",
      ),
    ],
  ),

  Patient(
    id: "p2",
    name: "Sneha Kulkarni",
    image: "assets/p2.jpg",
    phone: "9876543212",

    age: 29,
    trimester: "3rd Trimester",
    notes: "Monitor BP regularly",

    bloodGroup: "A+",
    height: 158,
    weight: 68,
    hemoglobin: 10.8,
    platelets: 2.2,

    reports: [
      Report(
        id: "r3",
        title: "Hemoglobin Report",
        fileUrl: "assets/reports/sample_blood_report.pdf",
        fileType: "pdf",
        date: "18 April 2026",
        doctorSuggestion: "Increase iron intake",
      ),
    ],
  ),
];
Doctor doctor = Doctor(
  name: "Dr. Priya Sharma",
  designation: "Gynecologist",
  hospital: "City Care Hospital",
  contact: "+91 9876543210",
  image: '',
);
List<Slot> slots = [
  Slot(
    id: "s1",

    date: DateTime(2026, 4, 20),

    times: ["10:00 AM", "11:30 AM", "02:00 PM"],
  ),

  Slot(
    id: "s2",

    date: DateTime(2026, 4, 21),

    times: ["09:30 AM", "12:00 PM", "03:30 PM"],
  ),
];
