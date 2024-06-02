import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';
import 'package:todo_app/features/todo/utils/todo_utils.dart';

import '../app/task_provider.dart';

class ActiveTasks extends ConsumerWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getActiveTasksForToday(tasks),
      builder: (__, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Pending Tasks',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colours.light.withOpacity(.6),
                  fontSize: 18,
                ),
              ),
            );
          }
          return ColoredBox(
            color: Colours.darkGrey,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final task = snapshot.data![index];
                final isLast = index == snapshot.data!.length - 1;
                return TodoTile(
                  task,
                  bottomMargin: isLast ? null : 10,
                  onDelete: () {
                    ref.read(taskProvider.notifier).deleteTask(task.id!);
                  },
                  onEdit: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddOrEditTaskScreen(
                                  task: task,
                                )));
                  },
                  endIcon: Switch(
                    value: task.isCompleted,
                    onChanged: (_) {
                      task.isCompleted = true;
                      ref.read(taskProvider.notifier).markAsCompleted(task);
                    },
                  ), // Switch
                );
              },
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
