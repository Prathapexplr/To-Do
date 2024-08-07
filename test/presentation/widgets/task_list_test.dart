import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/presentation/widgets/task_list.dart';
import 'package:todo/domain/entities/task.dart';

void main() {
  testWidgets('displays a list of tasks', (WidgetTester tester) async {
    final tasks = [Task(id: '1', title: 'Test Task', isCompleted: false)];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TaskList(tasks: tasks),
      ),
    ));

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
}
