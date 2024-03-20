import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/model/task_model.dart';
import 'package:to_do_app_flutter/service/notification_manager.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/utils/icon_enum.dart';
import 'package:to_do_app_flutter/widgets/my_button.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  TextEditingController dateController = TextEditingController();

  TextEditingController titleController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  TextEditingController iconController = TextEditingController();

  dateTimeToString() {
    context.read<MyService>().dateTimeToString(context, dateController);
  }

  timeOfDayToString() {
    context.read<MyService>().timeOfDayToString(context, timeController);
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants().catSkillWhite,
      appBar: AppBar(
        backgroundColor: ColorConstants().purpleHaze,
        title: Text(
          'Add New Task',
          style: context.general.textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.padding.low,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task title',
                style: context.general.textTheme.titleLarge,
              ),
              Padding(
                padding: context.padding.verticalLow,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'Task title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              Center(
                child: Text(
                  'Category',
                  style: context.general.textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: context.padding.horizontalLow +
                    context.padding.verticalNormal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customRadio(IconEnum.ic_event, 0),
                    customRadio(IconEnum.ic_goal, 1),
                    customRadio(IconEnum.ic_task, 2),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: context.padding.low,
                    child: Text(
                      'Date',
                      style: context.general.textTheme.titleLarge,
                    ),
                  ),
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
                      controller: dateController,
                      onTap: dateTimeToString,
                      decoration: InputDecoration(
                          hintText: 'Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  )
                ],
              ),
              Padding(
                padding: context.padding.onlyTopNormal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: context.padding.low,
                      child: Text(
                        'Time',
                        style: context.general.textTheme.titleLarge,
                      ),
                    ),
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
                        controller: timeController,
                        onTap: timeOfDayToString,
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
              Padding(
                padding: context.padding.horizontalLow +
                    context.padding.verticalNormal,
                child: Text(
                  'Notes',
                  style: context.general.textTheme.titleLarge,
                ),
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Notes',
                  border: OutlineInputBorder(),
                ),
                minLines: 3,
                maxLines: 10,
              ),
              Center(
                  child: MyButton(
                      title: 'Add',
                      onTap: () {
                        if (iconController.text.isEmpty) {
                          iconController.text = IconEnum.ic_event.name;
                        }
                        TaskModel task = TaskModel(
                            iconName: iconController.text,
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text,
                            note: noteController.text,
                            id: context.read<MyService>().idCreator());
                        context.read<MyService>().addNewTask(task);

                        NotificationHelper.scheduleNotification(
                            id: task.id,
                            title: titleController.text,
                            body: '',
                            payload: '',
                            scheduledDateTime: context
                                .read<MyService>()
                                .stringToDateTime(
                                    dateController.text, timeController.text));
                        Navigator.pop(context);
                      }))
            ],
          ),
        ),
      ),
    );
  }

  Widget customRadio(IconEnum imageName, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: const MaterialStatePropertyAll(
            CircleBorder(),
          ),
          backgroundColor: MaterialStatePropertyAll((_selectedIndex == index)
              ? ColorConstants().purpleHaze
              : Colors.transparent)),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
          iconController.text = imageName.name;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image(
          image: AssetImage('assets/icons/${imageName.name}.png'),
        ),
      ),
    );
  }
}
