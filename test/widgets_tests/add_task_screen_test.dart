import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('AddOrEditTaskScreen has input fields and a submit button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AddOrEditTaskScreen(),
        ),
      ),
    );

    // Verify the title input field
    expect(find.byType(TextField).at(0), findsOneWidget);

    // Verify the description input field
    expect(find.byType(TextField).at(1), findsOneWidget);

    // Verify the submit button
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('AddOrEditTaskScreen shows error when fields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AddOrEditTaskScreen(),
        ),
      ),
    );

    // Tap on the submit button
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // Verify the error message is shown
    expect(find.text('All Fields Are Required'), findsOneWidget);
  });
}
