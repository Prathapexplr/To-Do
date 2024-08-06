import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTask addTask;
  final DeleteTask deleteTask;
  final UpdateTask updateTask;
  final GetTasks getTasks;

  TaskBloc({
    required this.addTask,
    required this.deleteTask,
    required this.updateTask,
    required this.getTasks,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>((event, emit) async {
      final tasks = await getTasks();
      emit(TasksLoadedState(tasks));
    });

    on<AddTaskEvent>((event, emit) async {
      await addTask(event.task);
      final tasks = await getTasks();
      emit(TasksLoadedState(tasks));
    });

    on<UpdateTaskEvent>((event, emit) async {
      await updateTask(event.task);
      final tasks = await getTasks();
      emit(TasksLoadedState(tasks));
    });

    on<DeleteTaskEvent>((event, emit) async {
      await deleteTask(event.taskId);
      final tasks = await getTasks();
      emit(TasksLoadedState(tasks));
    });

    on<FilterTasksEvent>((event, emit) async {
      final tasks = await getTasks();
      final filteredTasks = tasks
          .where((task) => task.isCompleted == event.showCompleted)
          .toList();
      emit(TasksLoadedState(filteredTasks));
    });
  }
}
