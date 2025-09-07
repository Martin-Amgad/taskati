import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/constants/task_colors.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/feature/task/task_dispaly_screen.dart';
import 'package:taskati/feature/upload/pages/upload_screen.dart';

class TasksBuilder extends StatefulWidget {
  DateTime selectedDate;
  TasksBuilder({super.key, required this.selectedDate});

  @override
  State<TasksBuilder> createState() => _TasksBuilderState();
}

class _TasksBuilderState extends State<TasksBuilder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: LocalHelper.taskbox.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks = [];

          var selectedTaskDate = DateFormat(
            'yyyy-MM-dd',
          ).format(widget.selectedDate);

          for (var modal in box.values) {
            if (modal.date == selectedTaskDate) {
              tasks.add(modal);
            }
          }
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                children: [
                  LottieBuilder.asset(AppAssets.Emptyjson),
                  Text('No Tasks Found', style: TextStyles.getBody()),
                ],
              ),
            );
          }
          return ListView.separated(
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return TaskCard(task: tasks[index], box: box);
            },
            separatorBuilder: (context, index) {
              return Gap(10);
            },
            itemCount: tasks.length,
          );
        },
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.box});
  final TaskModel task;
  final Box box;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          box.put(task.id, task.copywith(isCompleted: true));
        } else {
          box.delete(task.id);
        }
      },
      background: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.check, color: AppColors.white),
            Text('Completed', style: TextStyles.getBody()),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.redcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: AppColors.white),
            Text('Delete', style: TextStyles.getBody()),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          context.pushTo(TaskDispalyScreen(taskModel: task));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: task.isCompleted ? Colors.green : TaskColors[task.color],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.getTitle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(6),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 17,
                          color: AppColors.white,
                        ),
                        Gap(6),
                        Text(
                          '${task.startTime} : ${task.endTime}',
                          style: TextStyles.getSmall(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    if (task.Description.isNotEmpty == true) ...[
                      Gap(6),
                      Text(
                        task.Description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.getBody(color: AppColors.white),
                      ),
                    ],
                  ],
                ),
              ),
              Gap(8),
              Container(width: 1, height: 50, color: AppColors.white),
              Gap(5),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted ? 'Completed' : 'Todo',
                  style: TextStyles.getBody(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
