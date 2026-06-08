import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.activeTaskCount,
    required this.doneTaskCount,
  });

  final int activeTaskCount;
  final int doneTaskCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Text(
              'Progress',
              style: TextStyle(
                color: AppColors.textMuted,
                fontWeight: FontWeight(900),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: LinearProgressIndicator(
                value: doneTaskCount / (activeTaskCount + doneTaskCount),
                color: AppColors.primaryColor,
                backgroundColor: AppColors.primaryLight,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$doneTaskCount/${activeTaskCount + doneTaskCount}',
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight(900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
