import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/task_expansion_tile.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';
import '../app/task_provider.dart';

class TasksForDayAfterTomorrow extends HookConsumerWidget {
  const TasksForDayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getTasksForDayAfterTomorrow(tasks),
      builder: (__, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final colour = Colours.randomColour();
          return TaskExpansionTile(
            title: 'More Tasks',
            color: colour,
            subTitle: "Excluding  Today's and Tomorrow's task",
            children: snapshot.data!.map((task) {
              final isLast = snapshot.data!
                      .indexWhere((element) => element.id == task.id) ==
                  snapshot.data!.length - 1;
              return TodoTile(
                colour: colour,
                task,
                bottomMargin: isLast ? null : 10,
                onDelete: () {
                  ref.read(taskProvider.notifier).deleteTask(task.id!);
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddOrEditTaskScreen(task: task),
                    ),
                  );
                },
                endIcon: Switch(
                  value: task.isCompleted,
                  onChanged: (_) {
                    task.isCompleted = true;
                    ref.read(taskProvider.notifier).markAsCompleted(task);
                  },
                ), // Switch
              );
            }).toList(), // snapshot.data!.map
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
