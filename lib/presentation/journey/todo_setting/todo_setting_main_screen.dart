import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/base_screen.dart';
import 'package:todo_app/presentation/journey/todo_setting/todo_setting_main_view.dart';

class TodoSettingMainScreen extends StatefulWidget {
  const TodoSettingMainScreen({super.key});

  @override
  State<TodoSettingMainScreen> createState() => _TodoSettingMainScreenState();
}

class _TodoSettingMainScreenState extends State<TodoSettingMainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: AppColor.white,
      child: BaseScreen(title: 'Todo Settings', widget: TodoSettingMainView()),
    );
  }
}
