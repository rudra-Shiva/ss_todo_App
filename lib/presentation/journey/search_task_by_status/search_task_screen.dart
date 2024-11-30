import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/base_screen.dart';
import 'package:todo_app/presentation/journey/search_task_by_status/search_task_view.dart';

class SearchTaskScreen extends StatefulWidget {
  const SearchTaskScreen({super.key});

  @override
  State<SearchTaskScreen> createState() => _SearchTaskScreenState();
}

class _SearchTaskScreenState extends State<SearchTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return const Material(
        color: AppColor.white,
        child: BaseScreen(title: 'Search Task By Status', widget: SearchTaskView(),)
    );
  }
}
