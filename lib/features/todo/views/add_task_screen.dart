import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/common/widgets/filled_field.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/features/on_boarding/views/widgets/round_button.dart';
import 'package:todo_app/features/todo/app/task_provider.dart';

import '../../../core/res/colours.dart';
import '../../../core/utils/core_utils.dart';
import '../app/task_date_provider.dart';
import '../models/task_model.dart';

class AddOrEditTaskScreen extends StatefulHookConsumerWidget {
  const AddOrEditTaskScreen({super.key, this.task});

  final TaskModel? task;

  @override
  ConsumerState<AddOrEditTaskScreen> createState() =>
      _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends ConsumerState<AddOrEditTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.task != null) {
        ref.read(taskDateProvider.notifier).changeDate(widget.task!.date!);
        ref
            .read(taskStartTimeProvider.notifier)
            .changeTime(widget.task!.startTime!);
        ref
            .read(taskEndTimeProvider.notifier)
            .changeTime(widget.task!.endTime!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: widget.task?.title);
    final descriptionController =
        useTextEditingController(text: widget.task?.description);
    final hintStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colours.lightGrey,
      fontWeight: FontWeight.w600,
    );

    final dateNotifier = ref.read(taskDateProvider.notifier);
    final startTimeNotifier = ref.read(taskStartTimeProvider.notifier);
    final endTimeNotifier = ref.read(taskEndTimeProvider.notifier);

    final dateProvider = ref.watch(taskDateProvider);
    final startProvider = ref.watch(taskStartTimeProvider);
    final endProvider = ref.watch(taskEndTimeProvider);

    if (widget.task != null) {}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colours.light,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          children: [
            const WhiteSpace(height: 20),
            FilledField(
              controller: titleController,
              hintText: 'Add Title',
              hintStyle: hintStyle,
            ),
            const WhiteSpace(height: 20),
            FilledField(
              controller: descriptionController,
              hintText: 'Add Description',
              hintStyle: hintStyle,
            ),
            const WhiteSpace(height: 20),
            RoundButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  minTime: DateTime.now(),
                  maxTime: DateTime(DateTime.now().year + 1),
                  theme: DatePickerTheme(
                    doneStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colours.green,
                    ),
                  ),
                  onConfirm: (date) {
                    dateNotifier.changeDate(date);
                  },
                );
              },
              text: dateProvider == null
                  ? 'Set date'
                  : dateNotifier.date() ?? 'Set date',
              backgroundColour: Colours.lightGrey,
              borderColour: Colours.light,
            ),
            const WhiteSpace(height: 20),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                          context: context,
                          message: 'Please Pick a Date First',
                        );
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          startTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    text: startProvider == null
                        ? 'Start Time'
                        : startTimeNotifier.time() ?? 'Start Time',
                    backgroundColour: Colours.lightGrey,
                    borderColour: Colours.light,
                  ), // RoundButton
                ), // Expanded
                const WhiteSpace(width: 9),
                Expanded(
                  child: RoundButton(
                    onPressed: () {
                      if (startProvider == null) {
                        CoreUtils.showSnackBar(
                          context: context,
                          message: 'Please Pick a Start Time First',
                        );
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        currentTime: startProvider,
                        onConfirm: (time) {
                          endTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    text: endProvider == null
                        ? 'End Time'
                        : endTimeNotifier.time() ?? 'End Time',
                    backgroundColour: Colours.lightGrey,
                    borderColour: Colours.light,
                  ), // RoundButton
                ), // Expanded
              ],
            ),
            const WhiteSpace(height: 20),
            RoundButton(
              onPressed: () async {
                if (titleController.text.trim().isNotEmpty &&
                    descriptionController.text.trim().isNotEmpty &&
                    dateProvider != null &&
                    startProvider != null &&
                    endProvider != null) {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();
                  final startTime = startProvider;
                  final endTime = endProvider;
                  final date = dateProvider;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  final task = TaskModel(
                    id: widget.task?.id,
                    repeat: widget.task == null ? true : widget.task!.repeat,
                    remind: widget.task == null ? true : widget.task!.remind,
                    title: title,
                    description: description,
                    date: date,
                    startTime: startTime,
                    endTime: endTime,
                  ); // TaskModel

                  if (widget.task != null) {
                    await ref.read(taskProvider.notifier).updateTask(task);
                  } else {
                    await ref.read(taskProvider.notifier).addTask(task);
                  }
                  navigator
                    ..pop()
                    ..pop();
                } else {
                  CoreUtils.showSnackBar(
                      context: context, message: 'All Fields Are Required');
                }
              },
              text: 'Submit',
              backgroundColour: Colours.green,
              borderColour: Colours.light,
            ),
          ],
        ),
      ),
    );
  }
}
