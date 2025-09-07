import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/constants/task_colors.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/feature/home/pages/home_screen.dart';
import 'package:taskati/feature/task/widget/labeled_textField%20.dart';

class TaskDispalyScreen extends StatefulWidget {
  const TaskDispalyScreen({super.key, this.taskModel});
  final TaskModel? taskModel;

  @override
  State<TaskDispalyScreen> createState() => _TaskDispalyScreenState();
}

class _TaskDispalyScreenState extends State<TaskDispalyScreen> {
  var TitleController = TextEditingController();
  var DescriptionController = TextEditingController();
  var DateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  var StartController = TextEditingController(
    text: DateFormat('hh:mm a').format(DateTime.now()),
  );
  var EndController = TextEditingController(
    text: DateFormat('hh:mm a').format(DateTime.now()),
  );
  DateTime? pickedDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  int selectedColor = 0;

  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    TitleController.text = widget.taskModel?.title ?? '';
    DescriptionController.text = widget.taskModel?.Description ?? '';
    DateController.text =
        widget.taskModel?.date ??
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    StartController.text =
        widget.taskModel?.startTime ??
        DateFormat('hh:mm a').format(DateTime.now());
    EndController.text =
        widget.taskModel?.endTime ??
        DateFormat('hh:mm a').format(DateTime.now());
    selectedColor = widget.taskModel?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
          style: TextStyles.getTitle(color: AppColors.primarycolor),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: MainButton(
            height: 55,
            title: widget.taskModel != null ? 'Update Task' : 'Create Task',
            onPressed: () {
              var id = ' ';
              if (widget.taskModel != null) {
                id = widget.taskModel!.id;
              } else {
                id = DateTime.now().millisecondsSinceEpoch.toString();
              }
              LocalHelper.cacheTask(
                id,
                TaskModel(
                  id: id,
                  title: TitleController.text,
                  Description: DescriptionController.text,
                  date: DateController.text,
                  startTime: StartController.text,
                  endTime: EndController.text,
                  color: selectedColor,
                  isCompleted: false,
                ),
              );
              if (formkey.currentState?.validate() ?? false) {
                context.pop(HomeScreen());
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledTextfield(
                  title: 'Title',
                  hintText: 'Enter title',
                  controller: TitleController,
                ),
                LabeledTextfield(
                  title: 'Description',
                  hintText: 'Enter description...',
                  controller: DescriptionController,
                  maxLines: 3,
                ),
                LabeledTextfield(
                  title: 'Date',
                  controller: DateController,
                  icon: IconButton(
                    onPressed: () async {
                      var selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: pickedDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365 * 3)),
                      );
                      if (selectedDate != null) {
                        pickedDate = selectedDate;
                        DateController.text = DateFormat(
                          'yyyy-MM-dd',
                        ).format(selectedDate);
                      }
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                  readOnly: true,
                ),
                Gap(12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledTextfield(
                            title: 'Start time',
                            controller: StartController,
                            validator: (value) {
                              if (startTime.isBefore(TimeOfDay.now())) {
                                return 'Start time cannot be in the past.';
                              } else if (startTime.isAfter(endTime)) {
                                return 'Start time must be before the end time';
                              }
                            },
                            icon: IconButton(
                              onPressed: () async {
                                var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  startTime = selectedTime;
                                  StartController.text = selectedTime.format(
                                    context,
                                  );
                                }
                              },
                              icon: Icon(Icons.access_time),
                            ),

                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledTextfield(
                            title: 'End time',
                            controller: EndController,
                            validator: (value) {
                              if (endTime.isBefore(TimeOfDay.now())) {
                                return 'End time must be after current time.';
                              } else if (endTime.isBefore(startTime)) {
                                return 'End time must be after the start time.';
                              }
                            },
                            icon: IconButton(
                              onPressed: () async {
                                var selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (selectedTime != null) {
                                  endTime = selectedTime;
                                  EndController.text = selectedTime.format(
                                    context,
                                  );
                                }
                              },
                              icon: Icon(Icons.access_time),
                            ),
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  'Color',
                  style: TextStyles.getBody(fontWeight: FontWeight.w600),
                ),
                Gap(7),
                Row(
                  spacing: 5,
                  children: List.generate(TaskColors.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: TaskColors[index],
                        child: selectedColor == index
                            ? Icon(Icons.check, color: AppColors.white)
                            : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
