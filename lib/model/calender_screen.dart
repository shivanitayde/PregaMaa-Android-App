import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final List tasks;

  CalendarScreen({required this.tasks});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.now();

  List getTasksForDay(DateTime day) {
    return widget.tasks.where((task) {
      if (task.date == null) return false;

      return task.date.year == day.year &&
          task.date.month == day.month &&
          task.date.day == day.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var tasks = getTasksForDay(selectedDay);

    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2023),
            lastDay: DateTime(2100),
            focusedDay: selectedDay,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
              });
            },
          ),

          Expanded(
            child: tasks.isEmpty
                ? Center(child: Text("No Tasks"))
                : ListView(
                    children: tasks.map((task) {
                      return ListTile(title: Text(task.title));
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
