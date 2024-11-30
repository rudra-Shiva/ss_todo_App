import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/base_screen.dart';
import 'package:todo_app/presentation/journey/todo_profile/todo_profile_main_view.dart';

class TodoProfileMainScreen extends StatefulWidget {
  const TodoProfileMainScreen({super.key});

  @override
  State<TodoProfileMainScreen> createState() => _TodoProfileMainScreenState();
}

class _TodoProfileMainScreenState extends State<TodoProfileMainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: AppColor.white,
      child: BaseScreen(title: 'User Profile View', widget: TodoProfileMainView()),
    );
  }
}
