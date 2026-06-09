import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key, required this.onOpenNewTaskOverlay});

  final void Function() onOpenNewTaskOverlay;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          border: Border.all(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onOpenNewTaskOverlay,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.add, color: AppColors.textMuted),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Add a new task...',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight(600),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
