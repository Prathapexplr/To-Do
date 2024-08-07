import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';

import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';
import '../widgets/task_list.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'All') {
                context.read<TaskBloc>().add(LoadTasksEvent());
              } else if (value == 'Completed') {
                context
                    .read<TaskBloc>()
                    .add(const FilterTasksEvent(showCompleted: true));
              } else if (value == 'Pending') {
                context
                    .read<TaskBloc>()
                    .add(const FilterTasksEvent(showCompleted: false));
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            context.read<TaskBloc>().add(LoadTasksEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is TasksLoadedState) {
            return TaskList(tasks: state.tasks);
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String title = controller.text;
                if (title.isNotEmpty) {
                  final task = Task(id: DateTime.now().toString(), title: title);
                  context.read<TaskBloc>().add(AddTaskEvent(task));
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
