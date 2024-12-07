import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/ui/error_screen/error_screen.dart';
import 'package:todo_app/presentation/journey/all_task_screen/all_task_screen.dart';
import 'package:todo_app/presentation/journey/search_task_by_status/search_task_screen.dart';
import 'package:todo_app/presentation/journey/specific_task_screen/specific_task_screen.dart';
import 'package:todo_app/presentation/journey/splash/splash_screen.dart';
import 'package:todo_app/presentation/journey/test/test.dart';
import 'package:todo_app/presentation/journey/todo_login/login.dart';
import 'package:todo_app/presentation/journey/todo_login/todo_user_register.dart';
import 'package:todo_app/presentation/journey/todo_main_screen/todo_main_screen.dart';
import 'package:todo_app/presentation/journey/todo_profile/todo_profile_main_screen.dart';
import 'package:todo_app/presentation/journey/todo_setting/todo_setting_main_screen.dart';
import 'package:todo_app/presentation/journey/todo_setting/todo_setting_main_view.dart';

class Routes{
  static Route<dynamic> getRoutes(RouteSettings settings){
    final route = settings.name;
    return getPages(route, settings);

  }

  static MaterialPageRoute getPages(String? route, RouteSettings settings){
    switch (route) {
      case RouteList.initialRoute:
        return _generateMaterialRoute(page: const SplashScreen());
      case RouteList.mainRoute:
        return _generateMaterialRoute(page: const ToDoMainScreen());
      case RouteList.loginRoute:
        return _generateMaterialRoute(page: const Login());
      case RouteList.registerRoute:
        return _generateMaterialRoute(page: const TodoUserRegister());
      case RouteList.allTaskDetails:
        return _generateMaterialRoute(page: const AllTaskScreen());
      case RouteList.searchTaskByNameOrStatus:
        return _generateMaterialRoute(page: const SearchTaskScreen());
      case RouteList.specificTaskDetails:
        return _generateMaterialRoute(page: SpecificTaskScreen(
          taskCategory: settings?.arguments as dynamic,
        ));
      case RouteList.test:
        return _generateMaterialRoute(page: const Test());
      case RouteList.userProfileView:
        return _generateMaterialRoute(page: const TodoProfileMainScreen());
      case RouteList.todoSettingView:
        return _generateMaterialRoute(page: const TodoSettingMainScreen());
      default:
        return _generateMaterialRoute(page: const ErrorScreen());
    }

  }
  static MaterialPageRoute _generateMaterialRoute({required Widget page}) =>
      MaterialPageRoute(
        builder: (_) => page,
      );
}