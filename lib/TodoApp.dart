import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/navigation/routes.dart';
import 'package:todo_app/common/ui/theme/todo_themedata.dart';


class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, screenSize) {
      return ScreenUtilInit(
          designSize: const Size(360, 760),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {

              return SafeArea(
                bottom: false,
                child: MaterialApp(
                  theme: ToDoThemeData.lightTheme,
                  debugShowCheckedModeBanner: true,
                  // localizationsDelegates: AppLocalizations.localizationsDelegates,
                  // supportedLocales: AppLocalizations.supportedLocales,
                  // locale: locale,
                  initialRoute: RouteList.initialRoute,
                  onGenerateRoute: Routes.getRoutes,
                  //title: env.appTitle,

                ),
              );
            }
          );
    });
  }
}
