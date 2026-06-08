import 'package:todo_app/app_colors.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Priority { low, medium, high }

const priorityColors = {
  Priority.low: AppColors.priorityLow,
  Priority.medium: AppColors.priorityMedium,
  Priority.high: AppColors.priorityHigh,
};

class Task {
  Task({
    required this.title,
    this.priority = Priority.medium,
    this.isDone = false,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final Priority priority;
  final bool isDone;

  Task copyWith({String? title, bool? isDone, Priority? priority}) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }
}
