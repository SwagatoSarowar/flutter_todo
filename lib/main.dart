import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/widgets/todo_app.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bgColor,
        cardColor: AppColors.cardColor,
      ),
      home: const TodoApp(),
    ),
  );
}
