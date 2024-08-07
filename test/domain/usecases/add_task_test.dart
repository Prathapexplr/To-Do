import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/add_task.dart';
import '../../test_utils.mocks.dart';

void main() {
  late AddTask usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = AddTask(mockTaskRepository);
  });

  final tTask = Task(id: '1', title: 'Test Task');

  test('should add a task to the repository', () async {
    when(mockTaskRepository.addTask(any)).thenAnswer((_) async {});

    await usecase(tTask);

    verify(mockTaskRepository.addTask(any)).called(1);
  });
}
