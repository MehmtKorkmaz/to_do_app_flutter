import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_flutter/model/task_model.dart';
import 'package:to_do_app_flutter/service/shared_manager.dart';
import 'package:to_do_app_flutter/utils/shared_enums.dart';

class MyService extends ChangeNotifier {
  List<TaskModel> taskList = [];
  List<TaskModel> todayList = [];

  void initTodayList() async {
    for (TaskModel task in taskList) {
      if (DateFormat('yyyy-MM-dd').format(DateTime.now()) == task.date) {
        if (todayList.contains(task)) {
          return;
        } else {
          todayList.add(task);
        }
      }
    }
    for (TaskModel task in todayList) {
      if (DateFormat('yyyy-MM-dd').format(DateTime.now()) != task.date) {
        todayList.remove(task);
      }
    }
  }

  void initList() async {
    taskList = await SharedManager.getTaskList(SharedEnums.itemList);
    initTodayList();
    notifyListeners();
  }

  void addNewTask(TaskModel task) {
    taskList.add(task);

    SharedManager.setStringList(SharedEnums.itemList, taskList);
    initList();
    notifyListeners();
  }

  void updateTask(int index, TaskModel task) {
    taskList[index] = task;
    SharedManager.setStringList(SharedEnums.itemList, taskList);
    notifyListeners();
  }

  void deleteTask(int id) {
    taskList.removeWhere((task) => task.id == id);
    todayList.removeWhere((task) => task.id == id);
    initTodayList();
    SharedManager.setStringList(SharedEnums.itemList, taskList);
    notifyListeners();
  }

  dateTimeToString(
    BuildContext context,
    TextEditingController dateController,
  ) async {
    var selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    notifyListeners();
  }

  timeOfDayToString(
    BuildContext context,
    TextEditingController timeController,
  ) async {
    var selectedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // ignore: use_build_context_synchronously
      timeController.text = selectedTime.format(context);
    }
    notifyListeners();
  }

  DateTime stringToDateTime(String date, String time) {
    DateTime dateTime = DateTime.parse('$date $time');
    return dateTime;
  }

  int idCreator() {
    int id = int.parse(DateFormat("Dmmss").format(DateTime.now()));

    return id;
  }
}
