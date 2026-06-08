import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/lists/list_title.dart';

class DoneList extends StatelessWidget {
  const DoneList({super.key, required this.taskList});

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTitle('pending'),
        SizedBox(height: 12),
        // ...taskList.map((task) => ListItem(task)),
      ],
    );
  }
}
