import 'package:todo/data/repositories/task_repository.dart';

import '../entities/task.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) {
    return repository.addTask(task);
  }
}
