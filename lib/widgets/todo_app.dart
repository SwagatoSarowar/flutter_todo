import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/models/filter.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/filters/filters.dart';
import 'package:todo_app/widgets/lists/task_list.dart';
import 'package:todo_app/widgets/progress_bar.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() {
    return _TodoAppState();
  }
}

class _TodoAppState extends State<TodoApp> {
  final _taskList = [
    Task(title: 'Task 1', priority: Priority.high, isDone: true),
    Task(title: 'Task 2', priority: Priority.high),
    Task(title: 'Task 3'),
    Task(title: 'Task 4', priority: Priority.high),
    Task(title: 'Task 5', priority: Priority.medium),
    Task(title: 'Task 6', priority: Priority.high),
    Task(title: 'Task 7', isDone: true),
    Task(title: 'Task 8', isDone: true),
    Task(title: 'Task 9', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
    Task(title: 'Task 10', isDone: true),
  ];

  var _filterItems = [
    const Filter(label: 'All', isSelected: true),
    const Filter(label: 'Active', isSelected: false),
    const Filter(label: 'Done', isSelected: false),
  ];

  void changeFilter(String label) {
    setState(() {
      _filterItems = _filterItems.map((item) {
        if (item.label == label) {
          return Filter(label: item.label, isSelected: true);
        } else {
          return Filter(label: item.label, isSelected: false);
        }
      }).toList();
    });
  }

  void switchIsDone(Task task) {
    setState(() {
      final taskIndex = _taskList.indexWhere((el) => el.id == task.id);

      _taskList[taskIndex] = task.copyWith(isDone: !task.isDone);
    });
  }

  void removeTask(Task task) {
    setState(() {
      _taskList.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final currentDate = DateFormat.MMMMEEEEd().format(now);
    final activeFilter = _filterItems
        .firstWhere((item) => item.isSelected)
        .label;

    final activeTasks = _taskList.where((t) => !t.isDone).toList();
    final doneTasks = _taskList.where((t) => t.isDone).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          titleSpacing: 0,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.primaryLight,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight(900)),
                ),
                const SizedBox(height: 4),
                Text(currentDate, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Filters(_filterItems, changeFilter),
            ProgressBar(
              activeTaskCount: activeTasks.length,
              doneTaskCount: doneTasks.length,
            ),
            Expanded(
              child: TaskList(
                activeFilter: activeFilter,
                activeTasks: activeTasks,
                doneTasks: doneTasks,
                onSwitchIsDone: switchIsDone,
                onRemoveTask: removeTask,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
