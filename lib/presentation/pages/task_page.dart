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
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: const Text(
          '  To-Do App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              _showFilterBottomSheet(context);
            },
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
        backgroundColor: Colors.white,
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
          backgroundColor: Colors.white,
          title: const Text(
            'ADD NEW TASK',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w800,
                fontSize: 17),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Enter Task",
              fillColor: Colors.white70,
            ),
          ),
          actions: [
            TextButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsetsDirectional.symmetric(horizontal: 30)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            TextButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsetsDirectional.symmetric(horizontal: 30)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                final String title = controller.text;
                if (title.isNotEmpty) {
                  final task =
                      Task(id: DateTime.now().toString(), title: title);
                  context.read<TaskBloc>().add(AddTaskEvent(task));
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext newContext) {
        return BlocProvider.value(
          value: BlocProvider.of<TaskBloc>(context),
          child: Container(
            color: Colors.black,
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.list, color: Colors.white),
                  title: const Text('All', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    context.read<TaskBloc>().add(LoadTasksEvent());
                    Navigator.pop(newContext);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.check, color: Colors.white),
                  title: const Text('Completed',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    context
                        .read<TaskBloc>()
                        .add(const FilterTasksEvent(showCompleted: true));
                    Navigator.pop(newContext);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.pending, color: Colors.white),
                  title: const Text('Pending',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    context
                        .read<TaskBloc>()
                        .add(const FilterTasksEvent(showCompleted: false));
                    Navigator.pop(newContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
