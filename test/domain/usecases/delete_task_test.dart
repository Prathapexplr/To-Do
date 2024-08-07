import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/usecases/delete_task.dart';
import '../../test_utils.mocks.dart';

void main() {
  late DeleteTask usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeleteTask(mockTaskRepository);
  });

  const String tTaskId = '1';

  test('Should delete the task from the repository using the task ID',
      () async {
    when(mockTaskRepository.deleteTask(any)).thenAnswer((_) async {});

    await usecase(tTaskId);

    verify(mockTaskRepository.deleteTask(tTaskId)).called(1);
  });
}
