import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:todo_app/features/todo/models/task_model.dart';

import '../../../core/res/colours.dart';
import '../../../core/utils/notification_helper.dart';
import '../utils/todo_utils.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTasks();
    state = data.map((taskData) => TaskModel.fromMap(taskData)).toList();
    _checkForTaskTimeUp();
  }

  void _checkForTaskTimeUp() {
    for (var task in state) {
      if (task.isTimeUp() && !task.isCompleted) {
        NotificationHelper.showNotification(
          title: 'Task Notification',
          body: 'Task "${task.title}" time is up!',
        );
      }
    }
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> deleteTask(int taskId) async {
    await DBHelper.deleteTask(taskId);
    refresh();
  }

  Future<void> updateTask(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await updateTask(task);
  }

  Future<List<TaskModel>> getTodayTasks() async {
    final data = await DBHelper.getTasks();
    final tasks = data.map((taskData) => TaskModel.fromMap(taskData)).toList();
    return TodoUtils.getTasksForToday(tasks);
  }
}
