import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_flutter/model/task_model.dart';
import 'package:to_do_app_flutter/utils/shared_enums.dart';

final class SharedManager {
  SharedManager._();

  static late final SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setStringList(
      SharedEnums key, List<TaskModel> taskList) async {
    List<String> tasksAsString = [];

    for (TaskModel task in taskList) {
      tasksAsString.add(jsonEncode(TaskModel.toJson(task)));
    }

    return await _sharedPreferences.setStringList(key.name, tasksAsString);
  }

  static Future<List<TaskModel>> getTaskList(SharedEnums key) async {
    List<TaskModel> taskList = [];

    List<String>? tasksAsString = _sharedPreferences.getStringList(key.name);

    if (tasksAsString != null) {
      for (String task in tasksAsString) {
        taskList.add(TaskModel.fromJson(jsonDecode(task)));
      }
    }

    return taskList;
  }
}
