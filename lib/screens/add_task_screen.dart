import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/providers/tasks_provider.dart';

import '../utilities/constants.dart';

class AddTaskSheet extends StatelessWidget {
  TextEditingController textfieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Add Task', style: kModalTitle),
          TextField(
            controller: textfieldController,
            style: kAddTextfieldStyle,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor, width: 4.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor, width: 4.0),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            minWidth: double.infinity,
            color: kPrimaryColor,
            child: Text('Add', style: kModalButtonText),
            onPressed: () {
              Provider.of<TasksProvider>(context, listen: false)
                  .addTask(text: textfieldController.text);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
