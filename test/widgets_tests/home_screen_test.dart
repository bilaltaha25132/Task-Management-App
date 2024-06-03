import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_app/features/todo/views/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('HomeScreen has a title and buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Verify the title
    expect(find.text('Task Management'), findsOneWidget);

    // Verify the add button
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify the progress button
    expect(find.byIcon(FontAwesome.line_chart), findsOneWidget);
  });
}
