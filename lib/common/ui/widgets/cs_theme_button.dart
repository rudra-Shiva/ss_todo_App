import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';

import '../theme/app_color.dart';

class ToDoThemeButton extends StatelessWidget {
  const ToDoThemeButton({
    Key? key,
    required this.buttonName,
    this.buttonBgColor = AppColor.csBlueThemeColor,
    this.buttonBorderColor = Colors.transparent,
    required this.onPressed,
    this.height = Dimen.dimen_45,
    this.width = double.infinity,
    this.edgeCircleRadius = Dimen.dimen_35,
    required this.textColor,
    this.progressText,
    this.style,
  }) : super(key: key);
  final double height;
  final double width;
  final String buttonName;
  final Color textColor;
  final Color buttonBgColor;
  final Color buttonBorderColor;
  final VoidCallback onPressed;
  final double edgeCircleRadius;
  final String? progressText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MaterialButton(
          onPressed: progressText==null?onPressed:null,
          minWidth: width,
          height: height,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(edgeCircleRadius),
          ),
          color: buttonBgColor,
          child: Text(
            progressText??buttonName,
            style: style??AppStyle.textStyleMedium16(color: textColor),
          ),
          disabledColor: AppColor.brownColor2

        ),
        progressText==null?const SizedBox():Positioned(
            bottom: Dimen.dimen_2.h,
            right: Dimen.dimen_10.w,
            left: Dimen.dimen_10.w,
            child: const LinearProgressIndicator(
              color: AppColor.white,
            )
        )
      ],
    );
  }
}
