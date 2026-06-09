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
    final isDone = task.isDone;

    return Card(
      color: AppColors.cardColor.withAlpha(isDone ? 155 : 255),
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
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? AppColors.primaryColor.withAlpha(155)
                      : Colors.white,
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),

                child: const Icon(Icons.check, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: priorityColors[task.priority]?.withAlpha(
                    isDone ? 155 : 255,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: const FontWeight(600),
                    color: AppColors.textPrimary.withAlpha(isDone ? 155 : 255),
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // const Spacer(),
              IconButton(
                onPressed: () {
                  onRemoveTask(task);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(139, 153, 153, 153),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
