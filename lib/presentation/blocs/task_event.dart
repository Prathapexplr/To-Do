import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class FilterTasksEvent extends TaskEvent {
  final bool showCompleted;

  const FilterTasksEvent({required this.showCompleted});

  @override
  List<Object> get props => [showCompleted];
}
