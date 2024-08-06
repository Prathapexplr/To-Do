import 'package:todo/data/repositories/task_repository.dart';

import '../entities/task.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) {
    return repository.updateTask(task);
  }
}
