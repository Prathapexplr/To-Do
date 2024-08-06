import 'package:todo/data/repositories/task_repository.dart';

import '../entities/task.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}
