import '../../domain/entities/task.dart';

abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<void> updateTask(Task task);
  Future<List<Task>> getTasks();
}
