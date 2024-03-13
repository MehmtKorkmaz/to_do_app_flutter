import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';
import 'package:to_do_app_flutter/views/add_task_view.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/widgets/my_button.dart';
import 'package:to_do_app_flutter/widgets/task_card.dart';
import 'package:to_do_app_flutter/widgets/task_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MyService>().initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants().catSkillWhite,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .25,
            color: ColorConstants().purpleHaze,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    DateFormat.yMEd().format(DateTime.now()),
                    style: context.general.textTheme.headlineMedium,
                  ),
                  Text(
                    'MY TODO LIST',
                    style: context.general.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              Padding(
                padding: context.padding.low,
                child: Container(
                    height: MediaQuery.of(context).size.height * .55,
                    decoration: BoxDecoration(
                        color: ColorConstants().white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Consumer<MyService>(
                      builder: (context, MyService, _) => ListView.builder(
                          controller: ScrollController(),
                          itemCount: MyService.taskList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: context.padding.horizontalLow,
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (_) {
                                          // deleteTaskFromList(index);
                                          MyService.deleteTask(index);
                                        },
                                        backgroundColor:
                                            ColorConstants().bloodBurst,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ]),
                                child: TaskCard(
                                  task: MyService.taskList[index],
                                  taskDetail: TaskDetail(
                                      task: MyService.taskList[index],
                                      index: index),
                                ),
                              ),
                            );
                          }),
                    )),
              ),
              MyButton(
                title: 'ADD NEW TASK',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTaskView()));
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
