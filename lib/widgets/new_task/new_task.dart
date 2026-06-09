import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});

  final void Function(Task) onAddTask;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  var _selectedPriority = Priority.medium;

  void _choosePriority(Priority prio) {
    setState(() {
      _selectedPriority = prio;
    });
  }

  void _addTask() {
    final taskTitle = _titleController.text.trim();

    if (taskTitle.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please make sure to add a valid title name.'),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }

    widget.onAddTask(Task(title: taskTitle, priority: _selectedPriority));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.4,
      expand: false,
      builder: (ctx, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'New Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight(600)),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _titleController,
                maxLength: 50,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight(600),
                ),
                decoration: InputDecoration(
                  label: const Text(
                    'TASK NAME',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight(900),
                      color: AppColors.textMuted,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'PRIORITY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight(900),
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (var i = 0; i < Priority.values.length; i++) ...[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: priorityColors[Priority.values[i]]?.withAlpha(
                            _selectedPriority == Priority.values[i] ? 100 : 50,
                          ),
                          border: Border.all(
                            color: Colors.black.withAlpha(
                              _selectedPriority == Priority.values[i]
                                  ? 150
                                  : 50,
                            ),
                            width: _selectedPriority == Priority.values[i]
                                ? 2
                                : 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            _choosePriority(Priority.values[i]);
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: priorityColors[Priority.values[i]],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(Priority.values[i].name.toUpperCase()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (i < Priority.values.length - 1)
                      const SizedBox(width: 10),
                  ],
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _addTask,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight(900)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
