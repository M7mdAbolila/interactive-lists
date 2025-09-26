
import 'package:flutter/material.dart';

import 'task_tile_widget.dart';

class TaskDismissibleWrapper extends StatelessWidget {
  const TaskDismissibleWrapper({
    super.key,
    required this.task,
    required this.index,
    required this.onConfirmDelete,
    required this.onDelete,
  });

  final String task;
  final int index;
  final Future<bool> Function(BuildContext context) onConfirmDelete;
  final void Function(BuildContext context) onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key ?? ValueKey(task),
      direction: DismissDirection.endToStart,
      background: const DecoratedBox(
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      confirmDismiss: (_) => onConfirmDelete(context),
      onDismissed: (_) => onDelete(context),
      child: TaskTileWidget(task: task, index: index),
    );
  }
}
