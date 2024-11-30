import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/base_screen.dart';
import 'package:todo_app/presentation/journey/specific_task_screen/specific_task_view.dart';


class SpecificTaskScreen extends StatefulWidget {
  final String? taskCategory;
  const SpecificTaskScreen({super.key, this.taskCategory,});

  @override
  State<SpecificTaskScreen> createState() => _SpecificTaskScreenState();
}

class _SpecificTaskScreenState extends State<SpecificTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: AppColor.white,
        child: BaseScreen(title: 'Category Task Details', widget: SpecificTaskView(specificTaskCategory: widget.taskCategory,),)
    );
  }
}
