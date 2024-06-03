import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';
import 'package:todo_app/features/todo/models/task_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('TodoTile displays task information',
      (WidgetTester tester) async {
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      date: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 1)),
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TodoTile(
              task,
              endIcon: const Icon(Icons.check),
            ),
          ),
        ),
      ),
    );

    // Verify task title
    expect(find.text('Test Task'), findsOneWidget);

    // Verify task description
    expect(find.text('Test Description'), findsOneWidget);

    // Verify end icon
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('TodoTile calls onEdit when edit icon is tapped',
      (WidgetTester tester) async {
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      date: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 1)),
    );

    bool editCalled = false;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TodoTile(
              task,
              endIcon: const Icon(Icons.check),
              onEdit: () {
                editCalled = true;
              },
            ),
          ),
        ),
      ),
    );

    // Tap the edit icon
    await tester.tap(find.byIcon(MaterialCommunityIcons.circle_edit_outline));
    await tester.pump();

    // Verify that onEdit was called
    expect(editCalled, isTrue);
  });

  testWidgets('TodoTile calls onDelete when delete icon is tapped',
      (WidgetTester tester) async {
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      date: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 1)),
    );

    bool deleteCalled = false;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TodoTile(
              task,
              endIcon: const Icon(Icons.check),
              onDelete: () {
                deleteCalled = true;
              },
            ),
          ),
        ),
      ),
    );

    // Tap the delete icon
    await tester.tap(find.byIcon(MaterialCommunityIcons.delete_circle));
    await tester.pump();

    // Verify that onDelete was called
    expect(deleteCalled, isTrue);
  });
}
