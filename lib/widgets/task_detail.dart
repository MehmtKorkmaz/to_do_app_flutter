import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/model/task_model.dart';
import 'package:to_do_app_flutter/service/notification_manager.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';
import 'package:to_do_app_flutter/utils/icon_enum.dart';
import 'package:to_do_app_flutter/widgets/my_button.dart';

class TaskDetail extends StatefulWidget {
  final TaskModel task;
  final int index;
  const TaskDetail({super.key, required this.task, required this.index});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    getTaskInfo();
    super.initState();
  }

  void getTaskInfo() {
    noteController.text = widget.task.note;
    dateController.text = widget.task.date;
    timeController.text = widget.task.time;
  }

  void dateTimeToString() {
    context.read<MyService>().dateTimeToString(context, dateController);
  }

  void timeOfDayToString() {
    context.read<MyService>().timeOfDayToString(context, timeController);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: ColorConstants().catSkillWhite,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.padding.onlyTopMedium +
                      context.padding.onlyBottomLow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                            'assets/icons/${widget.task.iconName}.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.task.title,
                          style:
                              context.general.textTheme.titleMedium!.copyWith(
                            fontSize: 20,
                            color: ColorConstants().darkJungleGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ColorConstants().purpleHaze,
                ),
                Padding(
                  padding: context.padding.onlyTopNormal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                              'assets/icons/${IconEnum.ic_calendar.name}.png'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: TextField(
                          onTap: dateTimeToString,
                          controller: dateController,
                          decoration: InputDecoration(
                              hintText: 'Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: context.padding.onlyTopNormal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          child: Image.asset(
                              'assets/icons/${IconEnum.ic_clock.name}.png'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: TextField(
                          onTap: timeOfDayToString,
                          controller: timeController,
                          decoration: InputDecoration(
                              hintText: 'Time',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: context.padding.normal,
                  child: Text(
                    'Your Note',
                    style: context.general.textTheme.titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: context.padding.horizontalLow,
                  child: TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      hintText: 'Notes',
                      border: OutlineInputBorder(),
                    ),
                    minLines: 3,
                    maxLines: 10,
                  ),
                ),
                Padding(
                  padding: context.padding.horizontalMedium,
                  child: MyButton(
                      title: 'Update',
                      onTap: () {
                        //updated task
                        TaskModel updatedTask = TaskModel(
                          iconName: widget.task.iconName,
                          title: widget.task.title,
                          time: timeController.text,
                          date: dateController.text,
                          note: noteController.text,
                          id: MyService().idCreator(),
                        );
                        // cancel current alarm
                        NotificationHelper.unScheduleNotification(
                            widget.task.id);
                        // new alarm
                        NotificationHelper.scheduleNotification(
                            id: updatedTask.id,
                            scheduledDateTime: MyService().stringToDateTime(
                                dateController.text, timeController.text));
                        //update task
                        context
                            .read<MyService>()
                            .updateTask(widget.index, updatedTask);

                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
