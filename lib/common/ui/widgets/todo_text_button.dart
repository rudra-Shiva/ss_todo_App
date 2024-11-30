
import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';

class ToDoTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const ToDoTextButton(
      {Key? key,
      required this.onPressed,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: AppStyle.textStyle12(color: AppColor.csBlueThemeColor, fontWeight: FontWeight.bold),
        ));
  }
}
