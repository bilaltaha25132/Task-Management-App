import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/task_expansion_tile.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';

import '../../../core/common/widgets/white_space.dart';
import '../app/task_provider.dart';

class TasksForTomorrow extends HookConsumerWidget {
  const TasksForTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expansionController = useExpansionTileController();
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getTasksForTomorrow(tasks),
      builder: (__, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final colour = Colours.randomColour();
          return TaskExpansionTile(
            title: "Tomorrow's Task",
            color: colour,
            subTitle: "Tomorrow's tasks are shown here",
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
