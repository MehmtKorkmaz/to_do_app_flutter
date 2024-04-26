import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:to_do_app_flutter/model/task_model.dart';
import 'package:to_do_app_flutter/widgets/task_detail.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  final TaskDetail taskDetail;
  const TaskCard({super.key, required this.task, required this.taskDetail});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool value = false;

  void showDetail() {
    showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        barrierDismissible: true,
        barrierLabel: 'K',
        barrierColor: Colors.black.withOpacity(0.8),
        context: context,
        pageBuilder: (context, _, __) {
          return widget.taskDetail;
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showDetail,
      child: Card(
        elevation: 0.4,
        child: Padding(
          padding: context.padding.low,
          child: ListTile(
            dense: true,
            leading: Image.asset('assets/icons/${widget.task.iconName}.png'),
            title: Text(widget.task.title ?? '',
                style: context.general.textTheme.titleMedium),
            subtitle: Text('${widget.task.date} - ${widget.task.time}',
                style: context.general.textTheme.labelMedium),
          ),
        ),
      ),
    );
  }
}
