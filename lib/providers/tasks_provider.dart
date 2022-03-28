import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

final _store = FirebaseFirestore.instance;

class TasksProvider with ChangeNotifier {
  List<Task> _taskList = [];

  List<Task> get tasks {
    return _taskList;
  }

  int get task_count {
    return _taskList.length;
  }

  void updateTasklist({required List<Task> list}) {
    _taskList = list;
    notifyListeners();
  }

  void deleteTask({required String id}) {
    _taskList.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void addTask({required String text, bool isChecked = false}) {
    _taskList.add(
      Task(
        id: Random().toString(),
        text: text,
        isChecked: isChecked,
      ),
    );
    notifyListeners();
  }

  void toggleTask(index) {
    _taskList[index].isChecked = !_taskList[index].isChecked;
    notifyListeners();
  }
}
