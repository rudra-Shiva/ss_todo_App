
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/base_screen.dart';
import 'package:todo_app/presentation/journey/todo_main_screen/todo_main_view.dart';

class ToDoMainScreen extends StatefulWidget {
  const ToDoMainScreen({super.key});

  @override
  State<ToDoMainScreen> createState() => _ToDoMainScreenState();
}

class _ToDoMainScreenState extends State<ToDoMainScreen> {
  void onBack()async {
    // SystemNavigator.pop();
    // exit(0);
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Material(
      color: AppColor.white,
      child: BaseScreen(title: 'Task Management App', onBackPress:onBack, widget: const ToDoMainView(),padding: EdgeInsets.zero,)
    );
  }
}
