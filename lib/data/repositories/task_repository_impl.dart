import 'package:todo/data/model/task_model.dart';
import 'package:todo/data/repositories/task_repository.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:uuid/uuid.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<TaskModel> _taskStorage = [];
  final uuid = const Uuid();

  @override
  Future<void> addTask(Task task) async {
    _taskStorage.add(TaskModel(
      id: uuid.v4(),
      title: task.title,
      isCompleted: task.isCompleted,
    ));
  }

  @override
  Future<void> deleteTask(String taskId) async {
    _taskStorage.removeWhere((task) => task.id == taskId);
  }

  @override
  Future<void> updateTask(Task task) async {
    final index = _taskStorage.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _taskStorage[index] = TaskModel(
        id: task.id,
        title: task.title,
        isCompleted: task.isCompleted,
      );
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    return _taskStorage
        .map((taskModel) => Task(
              id: taskModel.id,
              title: taskModel.title,
              isCompleted: taskModel.isCompleted,
            ))
        .toList();
  }
}
