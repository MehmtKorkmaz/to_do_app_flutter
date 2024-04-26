import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/service/notification_manager.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';
import 'package:to_do_app_flutter/widgets/task_card.dart';
import 'package:to_do_app_flutter/widgets/task_detail.dart';

class TodayTasksView extends StatefulWidget {
  const TodayTasksView({super.key});

  @override
  State<TodayTasksView> createState() => _TodayTasksViewState();
}

class _TodayTasksViewState extends State<TodayTasksView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyService>(
      builder: (context, myService, _) => ListView.builder(
          itemCount: myService.todayList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.padding.horizontalLow,
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (_) {
                      NotificationHelper.unScheduleNotification(
                          myService.todayList[index].id!);
                      myService.deleteTask(myService.taskList[index].id!);
                    },
                    backgroundColor: ColorConstants().bloodBurst,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ]),
                child: TaskCard(
                  task: myService.todayList[index],
                  taskDetail: TaskDetail(
                      task: myService.todayList[index], index: index),
                ),
              ),
            );
          }),
    );
  }
}
