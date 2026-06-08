import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/models/task.dart';

class ListItem extends StatelessWidget {
  const ListItem(
    this.task, {
    super.key,
    required this.onSwitchIsDone,
    required this.onRemoveTask,
  });

  final Task task;
  final void Function(Task) onSwitchIsDone;
  final void Function(Task) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          onSwitchIsDone(task);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: priorityColors[task.priority],
                ),
              ),
              const SizedBox(width: 12),
              Text(task.title, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 12),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onRemoveTask(task);
                },
                icon: const Icon(Icons.delete, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
