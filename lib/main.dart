import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/task_repository_impl.dart';
import 'domain/usecases/add_task.dart';
import 'domain/usecases/delete_task.dart';
import 'domain/usecases/get_tasks.dart';
import 'domain/usecases/update_task.dart';
import 'presentation/blocs/task_bloc.dart';
import 'presentation/pages/task_page.dart';

void main() {
  final taskRepository = TaskRepositoryImpl();

  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepositoryImpl taskRepository;

  const MyApp({super.key, required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        addTask: AddTask(taskRepository),
        deleteTask: DeleteTask(taskRepository),
        updateTask: UpdateTask(taskRepository),
        getTasks: GetTasks(taskRepository),
      ),
      child: const MaterialApp(
        home: TaskPage(),
      ),
    );
  }
}
