import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';

class TodoSettingMainView extends StatefulWidget {
  const TodoSettingMainView({super.key});

  @override
  State<TodoSettingMainView> createState() => _TodoSettingMainViewState();
}

class _TodoSettingMainViewState extends State<TodoSettingMainView> {
  @override
  Widget build(BuildContext context) {
    return  const Material(
      color: AppColor.white,
    );
  }
}
