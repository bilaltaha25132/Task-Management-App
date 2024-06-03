import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';

class ProgressScreen extends HookConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final completedTasks = tasks.where((task) => task.isCompleted).toList();
    final activeTasks = tasks.where((task) => !task.isCompleted).toList();
    final totalTasks = tasks.length;
    final completedPercentage = (completedTasks.length / totalTasks) * 100;
    final activePercentage = (activeTasks.length / totalTasks) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Task's Progress",
          style: GoogleFonts.poppins(fontSize: 20, color: Colours.light),
        ),
        backgroundColor: Colours.darkBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const WhiteSpace(height: 50),
            Image.asset(
              'assets/images/tasks progresss image.png',
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.height * 0.8,
            ),
            const WhiteSpace(height: 10),
            Text(
              'Task Completion Progress',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colours.light,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colours.green,
                      value: completedPercentage,
                      title:
                          'Completed ${completedPercentage.toStringAsFixed(1)}%',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colours.darkBackground,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colours.red,
                      value: activePercentage,
                      title: 'Active ${activePercentage.toStringAsFixed(1)}%',
                      radius: 100,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colours.darkBackground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
