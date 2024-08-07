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
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          title: Text(
            task.title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: task.isCompleted ? Colors.white : null),
          ),
          leading: Checkbox(
            checkColor: Colors.red,
            activeColor: Colors.white,
            value: task.isCompleted,
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(
                  width: 1.0, color: Color.fromARGB(255, 244, 199, 195)),
            ),
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
            color: const Color.fromARGB(255, 255, 86, 74),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
            },
          ),
        );
      },
    );
  }
}
