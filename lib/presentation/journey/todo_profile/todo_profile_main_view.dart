import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';

class TodoProfileMainView extends StatefulWidget {
  const TodoProfileMainView({super.key});

  @override
  State<TodoProfileMainView> createState() => _TodoProfileMainViewState();
}

class _TodoProfileMainViewState extends State<TodoProfileMainView> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: AppColor.white,
    );
  }
}
