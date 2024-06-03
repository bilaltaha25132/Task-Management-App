import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/models/task_model.dart';

void main() {
  group('TaskModel', () {
    test('should create a TaskModel from a map', () {
      final taskMap = {
        'id': 1,
        'title': 'Test Task',
        'description': 'Test Description',
        'isCompleted': 1,
        'date': '2024-06-01',
        'startTime': '2024-06-01 09:00:00',
        'endTime': '2024-06-01 10:00:00',
        'remind': 1,
        'repeat': 1,
      };

      final task = TaskModel.fromMap(taskMap);

      expect(task.id, 1);
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, true);
      expect(task.date, DateTime.parse('2024-06-01'));
      expect(task.startTime, DateTime.parse('2024-06-01 09:00:00'));
      expect(task.endTime, DateTime.parse('2024-06-01 10:00:00'));
      expect(task.remind, true);
      expect(task.repeat, true);
    });

    test('should convert a TaskModel to a map', () {
      final task = TaskModel(
        id: 1,
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: true,
        date: DateTime.parse('2024-06-01'),
        startTime: DateTime.parse('2024-06-01 09:00:00'),
        endTime: DateTime.parse('2024-06-01 10:00:00'),
        remind: true,
        repeat: true,
      );

      final taskMap = task.toMap();

      expect(taskMap['id'], 1);
      expect(taskMap['title'], 'Test Task');
      expect(taskMap['description'], 'Test Description');
      expect(taskMap['isCompleted'], 1);
      expect(taskMap['date'], '2024-06-01 00:00:00.000');
      expect(taskMap['startTime'], '2024-06-01 09:00:00.000');
      expect(taskMap['endTime'], '2024-06-01 10:00:00.000');
      expect(taskMap['remind'], 1);
      expect(taskMap['repeat'], 1);
    });
  });
}
