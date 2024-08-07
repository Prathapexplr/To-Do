import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/presentation/blocs/task_bloc.dart';
import 'package:todo/presentation/blocs/task_event.dart';
import 'package:todo/presentation/blocs/task_state.dart';
import 'package:todo/presentation/pages/task_page.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../test_utils.mocks.dart';

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
  });

  tearDown(() {
    mockTaskBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<TaskBloc>(
        create: (_) => mockTaskBloc,
        child: const TaskPage(),
      ),
    );
  }

  testWidgets('Should display loading indicator when state is TaskInitial',
      (WidgetTester tester) async {
    when(mockTaskBloc.state).thenReturn(TaskInitial());
    when(mockTaskBloc.stream).thenAnswer((_) => Stream.value(TaskInitial()));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display list of tasks when state is TasksLoadedState',
      (WidgetTester tester) async {
    final tasks = [
      Task(id: '1', title: 'Task 1', isCompleted: false),
      Task(id: '2', title: 'Task 2', isCompleted: true),
    ];
    when(mockTaskBloc.state).thenReturn(TasksLoadedState(tasks));
    when(mockTaskBloc.stream)
        .thenAnswer((_) => Stream.value(TasksLoadedState(tasks)));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
  });

  testWidgets('Should show add task dialog when FloatingActionButton is tapped',
      (WidgetTester tester) async {
    when(mockTaskBloc.state).thenReturn(const TasksLoadedState([]));
    when(mockTaskBloc.stream)
        .thenAnswer((_) => Stream.value(const TasksLoadedState([])));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('ADD NEW TASK'), findsOneWidget);
  });

  testWidgets('Should filter tasks', (WidgetTester tester) async {
    when(mockTaskBloc.state).thenReturn(const TasksLoadedState([]));
    when(mockTaskBloc.stream)
        .thenAnswer((_) => Stream.value(const TasksLoadedState([])));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();

    verify(mockTaskBloc.add(const FilterTasksEvent(showCompleted: true)))
        .called(1);
  });
}
