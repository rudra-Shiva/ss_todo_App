import 'package:flutter/material.dart';
import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/cs_theme_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ToDoThemeButton(
          buttonName: "Go to Home",
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteList.initialRoute, (route) => false);
          },
          textColor: AppColor.greyColor6,
        ),
      ),
    );
  }
}
