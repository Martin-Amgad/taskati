import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';

class LocalHelper {
  static late Box userbox;
  static late Box<TaskModel> taskbox;

  static String KUserBox = 'user';
  static String KTaskBox = 'task';

  static String KName = 'name';
  static String KImage = 'image';
  static String KIsUpload = 'KIsUpload';
  static String KDark = 'dark';
  static String KSelectedDate = 'selectedDate';

  static init() async {
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    await Hive.openBox(KUserBox);
    await Hive.openBox<TaskModel>(KTaskBox);

    userbox = Hive.box(KUserBox);
    taskbox = Hive.box<TaskModel>(KTaskBox);
  }

  static cacheData(String key, dynamic value) {
    userbox.put(key, value);
  }

  static getData(String key) {
    return userbox.get(key);
  }

  static cacheTask(String key, TaskModel value) {
    taskbox.put(key, value);
  }

  static gatTask(String key) {
    return taskbox.get(key);
  }
}
