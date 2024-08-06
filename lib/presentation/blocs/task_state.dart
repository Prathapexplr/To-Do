import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TasksLoadedState extends TaskState {
  final List<Task> tasks;

  const TasksLoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}
