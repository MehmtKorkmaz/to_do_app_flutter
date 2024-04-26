import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_flutter/service/google_ads.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';
import 'package:to_do_app_flutter/views/add_task_view.dart';
import 'package:to_do_app_flutter/service/service.dart';
import 'package:to_do_app_flutter/views/all_task_view.dart';
import 'package:to_do_app_flutter/views/today_task_view.dart';
import 'package:to_do_app_flutter/widgets/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    GoogleAds().loadInterstitialAd();
    context.read<MyService>().initList();
    context.read<MyService>().initTodayList();
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
                    'MY TO-DO LIST',
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
                width: MediaQuery.of(context).size.width,
              ),
              DefaultTabController(
                length: 2,
                child: Padding(
                  padding: context.padding.horizontalLow,
                  child: Container(
                      height: MediaQuery.of(context).size.height * .62,
                      decoration: BoxDecoration(
                          color: ColorConstants().white,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Column(
                        children: [
                          TabBar(tabs: [
                            Tab(
                              text: 'Today',
                              icon: Icon(Icons.today),
                            ),
                            Tab(
                              text: 'All',
                              icon: Icon(Icons.calendar_month),
                            ),
                          ]),
                          Expanded(
                            child: TabBarView(children: [
                              TodayTasksView(),
                              AllTaskView(),
                            ]),
                          )
                        ],
                      )),
                ),
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
