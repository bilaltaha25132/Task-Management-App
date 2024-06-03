import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';
import 'package:todo_app/features/todo/models/task_model.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  group('TaskProvider', () {
    final container = ProviderContainer();

    test('should start with an empty list of tasks', () {
      final taskList = container.read(taskProvider);
      expect(taskList, isEmpty);
    });

    test('should add a task', () async {
      final task = TaskModel(
        id: 1,
        title: 'Test Task',
        description: 'Test Description',
        date: DateTime.now(),
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
      );

      await container.read(taskProvider.notifier).addTask(task);

      final taskList = container.read(taskProvider);
      expect(taskList, isNotEmpty);
      expect(taskList.first.title, 'Test Task');
    });

    test('should update a task', () async {
      final task = TaskModel(
        id: 1,
        title: 'Updated Task',
        description: 'Updated Description',
        date: DateTime.now(),
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
      );

      await container.read(taskProvider.notifier).updateTask(task);

      final taskList = container.read(taskProvider);
      expect(taskList.first.title, 'Updated Task');
    });

    test('should delete a task', () async {
      await container.read(taskProvider.notifier).deleteTask(1);

      final taskList = container.read(taskProvider);
      expect(taskList, isEmpty);
    });
  });
}
