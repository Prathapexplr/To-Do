import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../../domain/entities/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) {
              final updatedTask = Task(
                id: task.id,
                title: task.title,
                isCompleted: value ?? false,
              );
              context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
            },
          ),
        );
      },
    );
  }
}
