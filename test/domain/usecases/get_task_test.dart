import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/get_tasks.dart';
import '../../test_utils.mocks.dart';

void main() {
  late GetTasks usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = GetTasks(mockTaskRepository);
  });

  final tTasks = [
    Task(id: '1', title: 'Task 1', isCompleted: false),
    Task(id: '2', title: 'Task 2', isCompleted: true),
  ];

  test('Should get all tasks from the repository', () async {
    when(mockTaskRepository.getTasks()).thenAnswer((_) async => tTasks);

    final result = await usecase();

    expect(result, tTasks);
    verify(mockTaskRepository.getTasks()).called(1);
  });
}
