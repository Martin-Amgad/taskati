import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/feature/home/pages/widgets/home_header.dart';
import 'package:taskati/feature/home/pages/widgets/tasks_builder.dart';
import 'package:taskati/feature/home/pages/widgets/today_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HomeHeader(),
              Gap(25),
              TodayHeader(
                selectedDate: selectedDate,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              Gap(25),
              TasksBuilder(selectedDate: selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}
