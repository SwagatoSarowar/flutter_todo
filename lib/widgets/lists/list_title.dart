import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';

class ListTitle extends StatelessWidget {
  const ListTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 16,
        fontWeight: FontWeight(900),
      ),
    );
  }
}
