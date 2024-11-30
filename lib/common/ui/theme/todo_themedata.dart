import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class ToDoThemeData {
  static ThemeData lightTheme = ThemeData.light(useMaterial3: false).copyWith(
    // brightness: Brightness.light,
    primaryColor: AppColor.csBlueThemeColor,
    // backgroundColor: AppColor.white,
    scaffoldBackgroundColor: AppColor.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: AppStyle.getTextTheme(),
    appBarTheme: const AppBarTheme(elevation: 0),
  );
}
