import 'package:flutter/material.dart';

import 'task_dismissible_wrapper.dart';

class TasksListWidget extends StatefulWidget {
  const TasksListWidget({super.key});

  @override
  State<TasksListWidget> createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  late final List<String> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = [
      'Review Clean Architecture',
      'Complete Flutter project',
      'Read about State Management',
      'Write unit tests',
      'Refactor old code',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: _tasks.isEmpty
          ? const Center(child: Text('No tasks available'))
          : ReorderableListView.builder(
              key: const ValueKey('tasks_list'),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: _tasks.length,
              onReorder: _reorderTasks,
              proxyDecorator: _proxyDecorator,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskDismissibleWrapper(
                  key: ValueKey(task),
                  task: task,
                  index: index,
                  onConfirmDelete: (context) => _confirmDeletion(context, task),
                  onDelete: (context) => _removeTask(context, task, index),
                );
              },
            ),
    );
  }

  Future<bool> _confirmDeletion(BuildContext context, String task) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete task?'),
          content: Text('Are you sure you want to delete "$task"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  void _removeTask(BuildContext context, String task, int index) {
    setState(() {
      _tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('"$task" deleted'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                final insertionIndex = index > _tasks.length
                    ? _tasks.length
                    : index;
                _tasks.insert(insertionIndex, task);
              });
            },
          ),
        ),
      );
  }

  void _reorderTasks(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final movedTask = _tasks.removeAt(oldIndex);
      _tasks.insert(newIndex, movedTask);
    });
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, animatedChild) {
        final scale = Tween<double>(begin: 1, end: 1.02).evaluate(animation);
        return Transform.scale(scale: scale, child: animatedChild);
      },
      child: child,
    );
  }
}
