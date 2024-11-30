import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/base_screen.dart';
import 'package:todo_app/presentation/journey/all_task_screen/all_task_view.dart';


class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return const Material(
        color: AppColor.white,
        child: BaseScreen(title: 'All Task Details', widget: AllTaskView(),)
    );
  }
}
