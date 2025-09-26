import 'package:flutter/material.dart';

class TaskTileWidget extends StatefulWidget {
  const TaskTileWidget({super.key, required this.task, required this.index});

  final String task;
  final int index;

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  bool _isCompelete = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        key: ValueKey(widget.index),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          spacing: 8,
          children: [
            ReorderableDragStartListener(
              index: widget.index,
              child: const Icon(Icons.drag_handle),
            ),

            Text(
              widget.task,
              style: TextStyle(
                fontSize: 18,
                decoration: _isCompelete ? TextDecoration.lineThrough : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Checkbox(
              value: _isCompelete,
              onChanged: (value) {
                setState(() {
                  _isCompelete = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
