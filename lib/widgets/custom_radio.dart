import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/utils/colors_constants.dart';
import 'package:to_do_app_flutter/utils/icon_enum.dart';

class CustomRadioButton extends StatefulWidget {
  final IconEnum iconName;
  final int index;
  final int selectedIndex;
  final void Function()? onPressed;
  const CustomRadioButton({
    super.key,
    required this.iconName,
    required this.index,
    required this.selectedIndex,
    this.onPressed,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: const MaterialStatePropertyAll(
            CircleBorder(),
          ),
          backgroundColor: MaterialStatePropertyAll(
              (widget.selectedIndex == widget.index)
                  ? ColorConstants().purpleHaze
                  : Colors.transparent)),
      onPressed: () {
        setState(() {
          widget.onPressed;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image(
          image: AssetImage('assets/icons/${widget.iconName.name}.png'),
        ),
      ),
    );
  }
}
