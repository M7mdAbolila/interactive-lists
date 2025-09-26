import 'package:flutter/material.dart';

import 'tasks_list_widget.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager'), centerTitle: true),
      body: const SafeArea(child: TasksListWidget()),
    );
  }
}
