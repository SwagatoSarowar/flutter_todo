import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/lists/list_item.dart';
import 'package:todo_app/widgets/lists/list_title.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.activeFilter,
    required this.activeTasks,
    required this.doneTasks,
    required this.onSwitchIsDone,
    required this.onRemoveTask,
  });

  final String activeFilter;
  final List<Task> activeTasks;
  final List<Task> doneTasks;
  final void Function(Task) onSwitchIsDone;
  final void Function(Task) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (activeFilter == 'All' || activeFilter == 'Active') ...[
          const SliverToBoxAdapter(child: ListTitle('pending')),

          if (activeTasks.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'No Task Pending. Good Job',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight(700),
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final task = activeTasks[index];
                return Dismissible(
                  key: ValueKey(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onDismissed: (_) {
                    onRemoveTask(task);
                  },
                  child: ListItem(
                    task,
                    onSwitchIsDone: onSwitchIsDone,
                    onRemoveTask: onRemoveTask,
                  ),
                );
              }, childCount: activeTasks.length),
            ),
        ],
        if (activeFilter == 'All' || activeFilter == 'Done') ...[
          const SliverToBoxAdapter(child: ListTitle('completed')),

          if (doneTasks.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'You Haven\'t Completed Any Task Yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight(700),
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final task = doneTasks[index];
                return Dismissible(
                  key: ValueKey(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onDismissed: (_) {
                    onRemoveTask(task);
                  },
                  child: ListItem(
                    task,
                    onSwitchIsDone: onSwitchIsDone,
                    onRemoveTask: onRemoveTask,
                  ),
                );
              }, childCount: doneTasks.length),
            ),
        ],
      ],
    );
  }
}
