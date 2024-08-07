import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/update_task.dart';

import '../../test_utils.mocks.dart';

void main() {
  late UpdateTask usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = UpdateTask(mockTaskRepository);
  });

  final tTask = Task(id: '1', title: 'Updated Task', isCompleted: true);

  test('should update the task in the repository', () async {
    when(mockTaskRepository.updateTask(any)).thenAnswer((_) async => null);

    await usecase(tTask);

    verify(mockTaskRepository.updateTask(tTask)).called(1);
  });
}
