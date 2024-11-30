import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/db_helper/db_helper.dart';
import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';
import 'package:todo_app/common/ui/widgets/ToDoListCallbackTile.dart';
import 'package:todo_app/common/ui/widgets/dialog_box/dialog_box.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';

final GlobalKey<_ToDoMainViewState> toDoMainViewKey =
GlobalKey<_ToDoMainViewState>();

class ToDoMainView extends StatefulWidget {
  const ToDoMainView({super.key});

  @override
  State<ToDoMainView> createState() => _ToDoMainViewState();
}

class _ToDoMainViewState extends State<ToDoMainView> {
  int _currentIndex = 0;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late Timer _timer;

  List<TaskModel> _ongoingTasks = [];
  int _categoryTaskCount = 0;
  int _categoryWorkCount = 0;
  int _categoryHealthCount = 0;
  int _categoryOtherCount = 0;
  bool shouldReload = false;
  // Define your pages or screens here

  Future<void> _loadOngoingTasks() async {
    DateTime currentDate = DateTime.now();
    int limit = 2;

    List<TaskModel>? ongoingTasks =
    await _databaseHelper.getOngoingTasksLimitedByDate(currentDate, limit);

    setState(() {
      _ongoingTasks = ongoingTasks!;
    });
  }

  Future<void> _fetchTaskCountForCategory(String category) async {
    if (category.startsWith("School", 0)) {
      int? taskCounts =
      await _databaseHelper.getTotalTasksForCategory(category);
      setState(() {
        _categoryTaskCount = taskCounts!;
      });
    } else if (category.startsWith("Work")) {
      int? taskCount = await _databaseHelper.getTotalTasksForCategory(category);
      setState(() {
        _categoryWorkCount = taskCount!;
      });
    } else if (category.startsWith("Health")) {
      int? taskCount = await _databaseHelper.getTotalTasksForCategory(category);
      setState(() {
        _categoryHealthCount = taskCount!;
      });
    } else if (category.startsWith("Other")) {
      int? taskCount = await _databaseHelper.getTotalTasksForCategory(category);
      setState(() {
        _categoryOtherCount = taskCount!;
      });
    }

    // print(_categoryTaskCount);
  }

  @override
  void initState() {
    super.initState();
    // Schedule auto-refresh after 1 minute
    // Schedule auto-refresh every 5 seconds
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _reloadPage();
    });
    setState(() {
      _loadOngoingTasks();
    });

    _fetchTaskCountForCategory("School");
    _fetchTaskCountForCategory("Work");
    _fetchTaskCountForCategory("Health");
    _fetchTaskCountForCategory("Other");
  }
  void _reloadPage() {
    // Check if the page is mounted before calling setState
    if (mounted) {
      setState(() {
        setState(() {
          _loadOngoingTasks();
        });

        _fetchTaskCountForCategory("School");
        _fetchTaskCountForCategory("Work");
        _fetchTaskCountForCategory("Health");
        _fetchTaskCountForCategory("Other");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const SidebarDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.only(left: Dimen.dimen_16.w, right: Dimen.dimen_16.w),
          child: Column(
            children: [
              SizedBox(
                height: Dimen.dimen_30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "My Tasks",
                      style: AppStyle.textStyleBold14(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteList.allTaskDetails);

                      },
                      child: Text(
                        "See all",
                        style: AppStyle.textStyle14(color: AppColor.blueColor1),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteList.specificTaskDetails,arguments: "School");
                    },
                    child: Container(
                      width: ScreenUtil().screenWidth / 2.3,
                      height: Dimen.dimen_100.h,
                      decoration: BoxDecoration(
                          color: AppColor.csOrangeThemeColor3,
                          border: Border.all(
                            color: AppColor.taskStatusBorderSchool,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimen.dimen_20.h)),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.taskCategorySchool,
                              Color.fromARGB(255, 21, 236, 229)
                            ],
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Dimen.dimen_20.w,
                            height: Dimen.dimen_20.h,
                            margin: EdgeInsets.only(
                              left: Dimen.dimen_10.w,
                              top: Dimen.dimen_10.h,
                            ),
                            padding: const EdgeInsets.all(Dimen.dimen_4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white,
                            ),
                            child: Center(
                              child: Text(
                                "1",
                                style:
                                AppStyle.textStyle10(color: AppColor.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimen.dimen_10.w, top: Dimen.dimen_10.h),
                            child: Text(
                              "School",
                              style: AppStyle.textStyle16(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimen.dimen_10.w, top: Dimen.dimen_10.h),
                            child: Text(
                              "$_categoryTaskCount Tasks",
                              style:
                              AppStyle.textStyle12(color: AppColor.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteList.specificTaskDetails,arguments: "Work");
                    },
                    child: Container(
                      width: ScreenUtil().screenWidth / 2.3,
                      height: Dimen.dimen_100.h,
                      decoration: BoxDecoration(
                          color: AppColor.csOrangeThemeColor3,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimen.dimen_20.h)),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.csOrangeThemeColor3,
                              Color.fromARGB(255, 21, 236, 229)
                            ],
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Dimen.dimen_20.w,
                            height: Dimen.dimen_20.h,
                            margin: EdgeInsets.only(
                              left: Dimen.dimen_10.w,
                              top: Dimen.dimen_10.h,
                            ),
                            padding: const EdgeInsets.all(Dimen.dimen_4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white,
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style:
                                AppStyle.textStyle10(color: AppColor.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimen.dimen_10.w, top: Dimen.dimen_10.h),
                            child: Text(
                              "Work",
                              style: AppStyle.textStyle16(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Dimen.dimen_10.w, top: Dimen.dimen_10.h),
                            child: Text(
                              "$_categoryWorkCount Tasks",
                              style:
                              AppStyle.textStyle12(color: AppColor.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimen.dimen_14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteList.specificTaskDetails,arguments: "Other");
                      },
                      child: Container(
                        width: ScreenUtil().screenWidth / 2.3,
                        height: Dimen.dimen_100.h,
                        decoration: BoxDecoration(
                            color: AppColor.csOrangeThemeColor3,
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimen.dimen_20.h)),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColor.cSBlueColor8,
                                Color.fromARGB(255, 21, 236, 229)
                              ],
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Dimen.dimen_20.w,
                              height: Dimen.dimen_20.h,
                              margin: EdgeInsets.only(
                                left: Dimen.dimen_10.w,
                                top: Dimen.dimen_10.h,
                              ),
                              padding: const EdgeInsets.all(Dimen.dimen_4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                              ),
                              child: Center(
                                child: Text(
                                  "3",
                                  style: AppStyle.textStyle10(
                                      color: AppColor.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimen.dimen_10.w,
                                  top: Dimen.dimen_10.h),
                              child: Text(
                                "Other",
                                style: AppStyle.textStyle16(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimen.dimen_10.w,
                                  top: Dimen.dimen_10.h),
                              child: Text(
                                "$_categoryOtherCount Tasks",
                                style:
                                AppStyle.textStyle12(color: AppColor.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteList.specificTaskDetails,arguments: "Health");
                      },
                      child: Container(
                        width: ScreenUtil().screenWidth / 2.3,
                        height: Dimen.dimen_100.h,
                        decoration: BoxDecoration(
                            color: AppColor.csOrangeThemeColor3,
                            border: Border.all(
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimen.dimen_20.h)),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColor.csGreenThemeColor,
                                Color.fromARGB(255, 21, 236, 229)
                              ],
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Dimen.dimen_20.w,
                              height: Dimen.dimen_20.h,
                              margin: EdgeInsets.only(
                                left: Dimen.dimen_10.w,
                                top: Dimen.dimen_10.h,
                              ),
                              padding: const EdgeInsets.all(Dimen.dimen_4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                              ),
                              child: Center(
                                child: Text(
                                  "4",
                                  style: AppStyle.textStyle10(
                                      color: AppColor.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimen.dimen_10.w,
                                  top: Dimen.dimen_10.h),
                              child: Text(
                                "Health",
                                style: AppStyle.textStyle16(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimen.dimen_10.w,
                                  top: Dimen.dimen_10.h),
                              child: Text(
                                "$_categoryHealthCount Tasks",
                                style:
                                AppStyle.textStyle12(color: AppColor.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimen.dimen_30.h,
                margin: EdgeInsets.only(top: Dimen.dimen_40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "On Going",
                      style: AppStyle.textStyleBold14(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteList.allTaskDetails);
                      },
                      child: Text(
                        "See all",
                        style: AppStyle.textStyle14(
                            color: AppColor.csRedThemeColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimen.dimen_266.h,
                child: ListView.builder(
                  itemCount: _ongoingTasks.length,
                  itemBuilder: (context, index) {
                    TaskModel task = _ongoingTasks[index];

                    return ToDoListCallbackTile(
                      taskModel: task,
                      onDeletePressed: (){
                        print("delete pressed");
                      },
                      onPressed: () async{
                        await DialogBox.onAddTaskPressed(context, existingTask: task,updateStateCallback:_loadOngoingTasks);

                        await _fetchTaskCountForCategory("School");
                        await _fetchTaskCountForCategory("Work");
                        await _fetchTaskCountForCategory("Health");
                        await _fetchTaskCountForCategory("Other");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  _alertDialogBox(context);
                }),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, RouteList.searchTaskByNameOrStatus);
              },
            ),
            const SizedBox(), // This creates an empty space for the center button
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.pushNamed(context, RouteList.userProfileView),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async{
                await DialogBox.onAddTaskPressedUsingBloc(context,updateStateCallback:_loadOngoingTasks);
                _loadOngoingTasks();
                _fetchTaskCountForCategory("School");
                _fetchTaskCountForCategory("Work");
                _fetchTaskCountForCategory("Health");
                _fetchTaskCountForCategory("Other");

              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
          await DialogBox.onAddTaskPressedUsingBloc(context,updateStateCallback:_loadOngoingTasks);
          _loadOngoingTasks();
          _fetchTaskCountForCategory("School");
          _fetchTaskCountForCategory("Work");
          _fetchTaskCountForCategory("Health");
          _fetchTaskCountForCategory("Other");
        },
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _alertDialogBox(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert Message'),
        content: const Text('Currently under development. Coming soon!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              _loadOngoingTasks();
              _fetchTaskCountForCategory("School");
              _fetchTaskCountForCategory("Work");
              _fetchTaskCountForCategory("Health");
              _fetchTaskCountForCategory("Other");
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              _loadOngoingTasks();
              _fetchTaskCountForCategory("School");
              _fetchTaskCountForCategory("Work");
              _fetchTaskCountForCategory("Health");
              _fetchTaskCountForCategory("Other");
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }


}
