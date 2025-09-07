import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String Description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String startTime;
  @HiveField(5)
  final String endTime;
  @HiveField(6)
  final int color;
  @HiveField(7)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.Description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.isCompleted,
  });

  copywith({
    String? title,
    String? Description,
    String? date,
    String? startTime,
    String? endTime,
    int? color,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      Description: Description ?? this.Description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
