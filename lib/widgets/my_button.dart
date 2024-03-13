import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';

class MyButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const MyButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: context.padding.onlyTopMedium,
        height: MediaQuery.of(context).size.height * .09,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: ColorConstants().purpleHaze,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: context.general.textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
