import 'package:sqflite/sqflite.dart';

import '../../features/todo/models/task_model.dart';

class DBHelper {
  static Future<void> createTables(Database database) async {
    await database.execute(
      'CREATE TABLE tasks('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title STRING, '
      'description TEXT, '
      'date STRING, '
      'startTime STRING, '
      'endTime STRING, '
      'remind INTEGER, '
      'repeat INTEGER, '
      'isCompleted INTEGER'
      ')',
    );
    await database.execute('CREATE TABLE users('
        'id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0, '
        'isVerified INTEGER DEFAULT 0'
        ')');
  }

  static Future<Database> db() async {
    return openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  ////TASKS
  static Future<void> addTask(TaskModel task) async {
    final localDb = await db();

    await localDb.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteTask(int taskId) async {
    final localDb = await db();
    await localDb.delete('tasks', where: "id = ?", whereArgs: [taskId]);
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final localDb = await db();
    return localDb.query('tasks', orderBy: 'id');
  }

  static Future<Map<String, dynamic>> getTaskById(int taskId) async {
    final localDb = await db();
    final tasks = await localDb.query(
      'tasks',
      where: "id = ?",
      whereArgs: [taskId],
      limit: 1,
    );

    if (tasks.isEmpty) return {};
    return tasks.first;
  }

  static Future<void> updateTask(TaskModel task) async {
    final localDb = await db();
    await localDb.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  ////Users

  static Future<void> createUser({required bool isVerified}) async {
    final localDb = await db();
    final data = {
      'isVerified': isVerified ? 1 : 0,
    };
    await localDb.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<bool> userExists() async {
    final localDb = await db();
    final userData = await localDb.query('users');
    return userData.isNotEmpty;
  }

  static Future<void> deleteUser() async {
    final localDb = await db();
    await localDb.delete('users');
  }
}
