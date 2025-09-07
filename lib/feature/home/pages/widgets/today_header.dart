import 'dart:io';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/feature/task/task_dispaly_screen.dart';

class TodayHeader extends StatefulWidget {
  DateTime selectedDate;
  void Function(DateTime)? onDateChange;

  TodayHeader({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  State<TodayHeader> createState() => _TodayHeaderState();
}

class _TodayHeaderState extends State<TodayHeader> {
  bool today = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM d, yyyy').format(widget.selectedDate),
                    style: TextStyles.getTitle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    today
                        ? 'Today'
                        : DateFormat.EEEE().format(widget.selectedDate),
                    style: TextStyles.getTitle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Gap(10),
            MainButton(
              title: '+ Add Task',
              onPressed: () {
                context.pushTo(TaskDispalyScreen());
              },
              width: 110,
              height: 45,
              fontSize: 14,
            ),
          ],
        ),
        Gap(20),
        DatePicker(
          DateTime.now(),
          height: 100,
          width: 90,
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColors.primarycolor,
          selectedTextColor: AppColors.white,
          dayTextStyle: TextStyles.getSmall(),
          monthTextStyle: TextStyles.getSmall(),
          dateTextStyle: TextStyles.getBody(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          onDateChange: (date) {
            setState(() {
              widget.onDateChange!(date);
              final now = DateTime.now();
              final todayDateOnly = DateTime(now.year, now.month, now.day);
              final selectedDateOnly = DateTime(
                date.year,
                date.month,
                date.day,
              );

              if (selectedDateOnly != todayDateOnly) {
                today = false;
              } else {
                today = true;
              }
            });
          },
        ),
      ],
    );
  }
}
