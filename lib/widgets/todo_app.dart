import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/models/filter.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/filters/filters.dart';
import 'package:todo_app/widgets/lists/task_list.dart';
import 'package:todo_app/widgets/new_task/new_task.dart';
import 'package:todo_app/widgets/new_task/new_task_button.dart';
import 'package:todo_app/widgets/progress_bar.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() {
    return _TodoAppState();
  }
}

class _TodoAppState extends State<TodoApp> {
  final List<Task> _taskList = [
    Task(
      title: 'Landing page redesign',
      isDone: false,
      priority: Priority.high,
    ),
    Task(
      title: 'Gym session (Leg day)',
      isDone: false,
      priority: Priority.medium,
    ),
    Task(title: 'Update npm packages', isDone: true, priority: Priority.low),
    Task(
      title: 'Meal prep high-protein food',
      isDone: false,
      priority: Priority.high,
    ),
    Task(title: 'Review pull requests', isDone: true, priority: Priority.low),
    Task(title: 'Drink 4L of water', isDone: false, priority: Priority.medium),
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
    final taskIndex = _taskList.indexOf(task);

    setState(() {
      _taskList.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('An item has beend removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _taskList.insert(taskIndex, task);
            });
          },
        ),
      ),
    );
  }

  void _addNewTask(Task task) {
    setState(() {
      _taskList.add(task);
    });
  }

  void _openNewTaskOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewTask(onAddTask: _addNewTask),
    );
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
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
              NewTaskButton(onOpenNewTaskOverlay: _openNewTaskOverlay),
            ],
          ),
        ),
      ),
    );
  }
}
