import 'package:mockito/annotations.dart';
import 'package:todo/data/repositories/task_repository.dart';
import 'package:todo/presentation/blocs/task_bloc.dart';

@GenerateMocks([TaskRepository, TaskBloc])
void main() {}
