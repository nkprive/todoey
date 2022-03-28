import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/providers/tasks_provider.dart';
import 'package:todoey/widget/task_tile.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 25.0),
      itemCount: Provider.of<TasksProvider>(context).tasks.length,
      itemBuilder: (BuildContext context, int index) {
        Task task = Provider.of<TasksProvider>(context).tasks[index];
        return TaskTile(
          id: task.id,
          text: task.text,
          isChecked: task.isChecked,
          toggle: () {
            Provider.of<TasksProvider>(context, listen: false)
                .toggleTask(index);
          },
        );
      },
    );
  }
}
