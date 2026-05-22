import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pregmaa/model/notification_service.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

// 🔹 Task Model
class Task {
  String title;
  bool isDone;
  DateTime? date;
  int notificationId; // 🔥 NEW

  Task({
    required this.title,
    this.isDone = false,
    this.date,
    required this.notificationId,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
    'date': date?.toIso8601String(),
    'notificationId': notificationId,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    isDone: json['isDone'],
    date: json['date'] != null ? DateTime.parse(json['date']) : null,
    notificationId: json['notificationId'] ?? 0,
  );
}

class _TodoListState extends State<TodoList> {
  List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();
  bool _isAdding = false;
  bool _darkMode = false;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // 🔹 Load Tasks (with fallback fix)
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      setState(() {
        _tasks = taskList.map((e) {
          try {
            return Task.fromJson(jsonDecode(e));
          } catch (_) {
            return Task(
              title: e,
              notificationId: DateTime.now().millisecondsSinceEpoch,
            );
          }
        }).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList = _tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('tasks', taskList);
  }

  // 🔹 Add Task
  void _handleAddTask() {
    setState(() {
      if (!_isAdding) {
        _isAdding = true;
      } else {
        if (_controller.text.trim().isNotEmpty && _selectedDateTime != null) {
          int id = DateTime.now().millisecondsSinceEpoch;

          _tasks.insert(
            0,
            Task(
              title: _controller.text.trim(),
              date: _selectedDateTime,
              notificationId: id,
            ),
          );

          // 🔔 notification
          NotificationService.scheduleNotification(
            id,
            _controller.text.trim(),
            _selectedDateTime!,
          );

          _controller.clear();
          _selectedDateTime = null;

          _saveTasks();
        }

        _isAdding = false;
      }
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
    _saveTasks();
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
    NotificationService.cancelNotification(task.notificationId);

    _saveTasks();
  }

  // edit task
  void _editTask(Task task, String newTitle, DateTime newDate) {
    // 🔥 cancel old notification
    NotificationService.cancelNotification(task.notificationId);

    // 🔥 new ID
    int newId = DateTime.now().millisecondsSinceEpoch;

    setState(() {
      task.title = newTitle;
      task.date = newDate;
      task.notificationId = newId;
    });

    // 🔔 schedule new notification
    NotificationService.scheduleNotification(newId, newTitle, newDate);

    _saveTasks();
  }

  //pick date time
  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  // 🔥 Date Picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDateTime = picked;
      });
    }
  }

  void _confirmDelete(Task task) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(task);
              Navigator.pop(context);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var pending = _tasks.where((t) => !t.isDone).toList();
    var completed = _tasks.where((t) => t.isDone).toList();

    double progress = _tasks.isEmpty ? 0 : completed.length / _tasks.length;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ultimate To-Do"),
          actions: [
            IconButton(
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _darkMode = !_darkMode;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // 🔥 Progress
            Padding(
              padding: const EdgeInsets.all(10),
              child: LinearProgressIndicator(value: progress),
            ),

            // 🔹 Input
            if (_isAdding)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: "Enter task"),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: _pickDateTime,
                          child: Text("Pick Date & Time"),
                        ),
                        if (_selectedDateTime != null)
                          Text(
                            "${_selectedDateTime!.day}/${_selectedDateTime!.month} "
                            "${_selectedDateTime!.hour}:${_selectedDateTime!.minute}",
                          ),
                      ],
                    ),
                  ],
                ),
              ),

            // 🔥 List
            Expanded(
              child: ListView(
                children: [
                  // Pending
                  ...pending.map((task) {
                    int index = _tasks.indexOf(task);
                    return Dismissible(
                      key: Key(task.title + index.toString()),
                      onDismissed: (_) => _deleteTask(task),
                      child: ListTile(
                        title: Text(task.title),
                        subtitle: task.date != null
                            ? Text("${task.date!.day}/${task.date!.month}")
                            : null,
                        leading: Checkbox(
                          value: task.isDone,
                          onChanged: (_) => _toggleTask(index),
                        ),
                      ),
                    );
                  }),

                  // Completed
                  ...completed.map((task) {
                    int index = _tasks.indexOf(task);
                    return GestureDetector(
                      onLongPress: () => _confirmDelete(task),
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        leading: Checkbox(
                          value: task.isDone,
                          onChanged: (_) => _toggleTask(index),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleAddTask,
          child: Icon(_isAdding ? Icons.check : Icons.add),
        ),
      ),
    );
  }
}
