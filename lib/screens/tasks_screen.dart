import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/providers/tasks_provider.dart';

import '../models/task.dart';
import '../utilities/constants.dart';
import '../widget/task_list.dart';
import 'add_task_screen.dart';

final _store = FirebaseFirestore.instance;

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> taskModelList = [];

  void getTasks() async {
    await for (var snapshot in _store.collection('tasks').snapshots()) {
      List<Task> taskList = [];
      for (var task in snapshot.docs) {
        taskList.add(
          Task(
            id: task.id,
            text: task['text'],
            isChecked: task['isChecked'],
          ),
        );
        Provider.of<TasksProvider>(context, listen: false)
            .updateTasklist(list: taskList);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskSheet(),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.list_rounded,
                          size: 45.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Todoey',
                        style: kTitleStyle,
                      ),
                      Text(
                        '${Provider.of<TasksProvider>(context).task_count}',
                        style: kSubTitleStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TaskList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
