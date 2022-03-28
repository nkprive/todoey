import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/providers/tasks_provider.dart';

import '../utilities/constants.dart';

class TaskTile extends StatelessWidget {
  String id;
  bool isChecked = false;
  String text;
  Function toggle;

  TaskTile(
      {required this.isChecked,
      required this.text,
      required this.toggle,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) {
        // Remove the item from the data source.
        Provider.of<TasksProvider>(context, listen: false).deleteTask(id: id);
        // Then show a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted: "$text"'),
          ),
        );
      },
      child: ListTile(
        title: Text(
          text,
          style: kTaskTextStyle.copyWith(
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),git
        trailing: Checkbox(
          activeColor: kPrimaryColor,
          value: isChecked,
          onChanged: (bool? value) {
            toggle();
          },
        ),
      ),
    );
  }
}
