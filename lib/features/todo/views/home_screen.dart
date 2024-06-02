import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/common/widgets/filled_field.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colours.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/completed_tasks.dart';

import '../../authentication/views/sign_in_screen.dart';
import '../widgets/active_tasks.dart';
import '../widgets/tasks_for_day_after_tomorrow.dart';
import '../widgets/tasks_for_tomorrow.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final tabTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colours.darkBackground,
      fontWeight: FontWeight.bold,
    );

    ref.read(taskProvider.notifier).refresh();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        icon: const Icon(
                          AntDesign.logout,
                          color: Colours.light,
                        ),
                      ),
                    ),
                    Text(
                      'Task Management',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colours.light,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ), // RoundedRectangleBorder
                        backgroundColor: Colours.light,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddOrEditTaskScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colours.darkBackground,
                      ), // Icon
                    ), // IconButton.filled
                  ],
                ),
                const WhiteSpace(height: 20),
                const FilledField(
                  prefixIcon: Icon(AntDesign.search1, color: Colours.lightGrey),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    FontAwesome.sliders,
                    color: Colours.lightGrey,
                  ), // Icon
                ), // FilledField
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            children: [
              Row(
                children: [
                  const Icon(FontAwesome.tasks, size: 20, color: Colours.light),
                  const WhiteSpace(width: 10),
                  Text(
                    "Today's Tasks",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colours.light,
                    ),
                  ),
                ],
              ),
              const WhiteSpace(height: 25),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ColoredBox(
                  color: Colours.light,
                  child: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ), // BoxDecoration
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,
                    labelColor: Colours.lightBlue,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colours.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelColor: Colours.light,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: screenWidth / 2,
                          child: Center(
                            child: Text(
                              'Pending',
                              style: tabTextStyle,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          width: screenWidth / 2,
                          child: Center(
                            child: Text(
                              'Completed',
                              style: tabTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const WhiteSpace(height: 20),
              SizedBox(
                height: screenHeight * .26,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      ActiveTasks(),
                      CompletedTasks(),
                    ],
                  ),
                ), // TabBarView
              ),
              const WhiteSpace(height: 20),
              const TasksForTomorrow(),
              const WhiteSpace(height: 20),
              const TasksForDayAfterTomorrow(),
            ],
          ),
        ),
      ),
    );
  }
}
