import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';
import 'package:todo_app/common/ui/widgets/ToDoListCallbackTile.dart';
import 'package:todo_app/common/ui/widgets/circular_chart.dart';
import 'package:todo_app/common/ui/widgets/dialog_box/dialog_box.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:todo_app/presentation/bloc/get_total_count_specific_category_wise/get_totoal_count_specific_category_wise_bloc.dart';
import 'package:todo_app/presentation/bloc/specific_category_task/specific_category_task_bloc.dart';

class SpecificTaskView extends StatefulWidget {
  final String? specificTaskCategory;
  const SpecificTaskView({super.key, this.specificTaskCategory});

  @override
  State<SpecificTaskView> createState() => _SpecificTaskViewState();
}

class _SpecificTaskViewState extends State<SpecificTaskView> {
  late SpecificCategoryTaskBloc _specificCategoryTaskBloc;
  late GetTotalCountSpecificCategoryWiseBloc _countSpecificCategoryWiseBloc;
  late DeleteTaskBloc _deleteTaskBloc;
  bool shouldReload = false;
  int totalTask = 0;
  int totalTasks = 0;
  int completedTask = 0;
  double percentageTask = 0;

  @override
  void initState() {
    super.initState();
    _specificCategoryTaskBloc = getInstance<SpecificCategoryTaskBloc>();
    _specificCategoryTaskBloc
        .add(SpecificCategoryFinalTaskEvent(widget.specificTaskCategory!));
    if (!_specificCategoryTaskBloc.isClosed) {
      _specificCategoryTaskBloc
          .add(SpecificCategoryFinalTaskEvent(widget.specificTaskCategory!));
    }

    _countSpecificCategoryWiseBloc =
        getInstance<GetTotalCountSpecificCategoryWiseBloc>();
    _countSpecificCategoryWiseBloc
        .add(GetTotalCountFinalEvent(widget.specificTaskCategory!));
    if (_countSpecificCategoryWiseBloc.isClosed) {
      _countSpecificCategoryWiseBloc
          .add(GetTotalCountFinalEvent(widget.specificTaskCategory!));
    }

    _deleteTaskBloc = getInstance<DeleteTaskBloc>();
  }

  Future<void> _loadTask() async {
    if (!_specificCategoryTaskBloc.isClosed) {
      _specificCategoryTaskBloc
          .add(SpecificCategoryFinalTaskEvent(widget.specificTaskCategory!));
    }
    _countSpecificCategoryWiseBloc
        .add(GetTotalCountFinalEvent(widget.specificTaskCategory!));
    if (_countSpecificCategoryWiseBloc.isClosed) {
      _countSpecificCategoryWiseBloc
          .add(GetTotalCountFinalEvent(widget.specificTaskCategory!));
    }
  }

  Future<void> _deleteTask(int taskId) async {
    if (!_deleteTaskBloc.isClosed) {
      _deleteTaskBloc.add(DeleteEventInitiated(taskId));
    }
  }

  @override
  void dispose() {
    super.dispose();
    totalTask = 0;
    // _countSpecificCategoryWiseBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _specificCategoryTaskBloc),
        BlocProvider.value(value: _deleteTaskBloc),
        BlocProvider.value(value: _countSpecificCategoryWiseBloc),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: Dimen.dimen_200.h,
              decoration: BoxDecoration(
                  // color: AppColor.taskCategorySchool,
                  border: Border.all(
                    color: AppColor.taskStatusBorderSchool,
                  ),
                  borderRadius: BorderRadius.circular(
                      20), // use instead of BorderRadius.all(Radius.circular(20))
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.specificTaskCategory!.contains("School")
                          ? [
                              AppColor.taskCategorySchool,
                              const Color.fromARGB(255, 21, 236, 229),
                            ]
                          : widget.specificTaskCategory!.contains("Work")
                              ? [
                                  AppColor.csOrangeThemeColor3,
                                  const Color.fromARGB(255, 21, 236, 229)
                                ]
                              : widget.specificTaskCategory!.contains("Health")
                                  ? [
                                      AppColor.csGreenThemeColor,
                                      const Color.fromARGB(255, 21, 236, 229)
                                    ]
                                  : [
                                      AppColor.cSBlueColor8,
                                      const Color.fromARGB(255, 21, 236, 229)
                                    ])),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimen.dimen_10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.specificTaskCategory ?? "All Tasks",
                          style: AppStyle.textStyle20(
                              fontWeight: FontWeight.w500,
                              color: AppColor.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              size: Dimen.dimen_18.sp,
                            ),
                            SizedBox(
                              width: Dimen.dimen_20.w,
                            ),
                            IconButton(
                                // onPressed: () => _onAddTaskPressed(context),
                                onPressed: () async {
                                  DialogBox.onAddTaskPressed(context);
                                  await _loadTask();
                                },
                                icon: const Icon(Icons.add))
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: BlocBuilder<GetTotalCountSpecificCategoryWiseBloc,
                        GetTotalCountSpecificCategoryWiseState>(
                      builder: (context, state) {
                        if (state is GetTotalCountProgress) {
                          totalTasks = 0;
                          completedTask = 0;
                          percentageTask = 0;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.applicationTrackerBg,
                            ),
                          );
                        }
                        if (state is GetTotalCountSuccess) {
                          totalTasks = state.totalCategoryWiseTask;
                          completedTask = state.totalCompletedTask;
                          percentageTask = (completedTask / totalTasks) * 100;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Tasks",
                                    style: AppStyle.textStyle20(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Completed Tasks",
                                        style: AppStyle.textStyle14(
                                            color: AppColor.white),
                                      ),
                                      SizedBox(
                                        width: Dimen.dimen_6.w,
                                      ),
                                      Text(
                                        "$completedTask/$totalTasks",
                                        style: AppStyle.textStyle14(
                                            color: AppColor.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              MyCircularChart(
                                percentageTask: percentageTask,
                                completedTask: completedTask,
                                totalTasks: totalTasks,
                              ),
                              // AnimatedCircularChart(
                              //   key: _chartKey,
                              //   size: const Size(160.0, 160.0),
                              //   initialChartData: <CircularStackEntry>[
                              //     CircularStackEntry(
                              //       <CircularSegmentEntry>[
                              //         CircularSegmentEntry(
                              //           percentageTask,
                              //           Colors.blue[400],
                              //           rankKey: 'completed',
                              //         ),
                              //         CircularSegmentEntry(
                              //           100-percentageTask,
                              //           Colors.blueGrey[600],
                              //           rankKey: 'remaining',
                              //         ),
                              //       ],
                              //       rankKey: 'progress',
                              //     ),
                              //   ],
                              //   chartType: CircularChartType.Radial,
                              //   percentageValues: true,
                              //   holeLabel: '$completedTask/$totalTasks',
                              //   labelStyle: TextStyle(
                              //     color: AppColor.white,
                              //     fontWeight: FontWeight.bold,
                              //     fontSize: Dimen.dimen_20.sp,
                              //   ),
                              // )
                            ],
                          );
                        }
                        return Card(
                          color: AppColor.white,
                          margin: EdgeInsets.only(top: Dimen.dimen_30.h),
                          elevation: Dimen.dimen_5,
                          child: Center(
                              widthFactor: Dimen.dimen_2.w,
                              heightFactor: Dimen.dimen_3.h,
                              child: Text(
                                "No Data Available",
                                style: AppStyle.textStyle12(),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimen.dimen_20.h,
            ),
            const Divider(
              color: AppColor.blueBlack4,
            ),
            BlocBuilder<SpecificCategoryTaskBloc, SpecificCategoryTaskState>(
              builder: (context, state) {
                if (state is SpecificCategoryTaskProgress) {
                  return SizedBox(
                    height: ScreenUtil().screenHeight - 320.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.blueColor1,
                      ),
                    ),
                  );
                } else if (state is SpecificCategoryTaskFailed) {
                  if (state.message!
                      .contains("AppError(AppErrorType.database)")) {
                    return const Card(
                      elevation: Dimen.dimen_6,
                      child: ListTile(
                        title: Text("No Task Available Now"),
                      ),
                    );
                  }
                  return Center(
                    child: Text(state.message!),
                  );
                } else if (state is SpecificCategoryTaskSuccess) {
                  return SizedBox(
                    height: ScreenUtil().screenHeight - 320.h,
                    child: ListView.builder(
                      itemCount: state.taskModel.length,
                      itemBuilder: (context, index) {
                        TaskModel task = state.taskModel[index];
                        // totalTask = state.taskModel.length;
                        if (state.taskModel.isEmpty) {
                          return const ListTile(
                            title: Text("No Task Available Now"),
                          );
                        } else {
                          return BlocConsumer<DeleteTaskBloc, DeleteTaskState>(
                            listener: (context, state) async {
                              if (state is DeleteTaskSuccess) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(Dimen.dimen_8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(height: Dimen.dimen_16.h),
                                          Text(
                                            'Task deleted with Id: ${state.taskId}',
                                            style: AppStyle.textStyle16(
                                                color: AppColor.blueBlack4),
                                          ),
                                          SizedBox(height: Dimen.dimen_16.h),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                await Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  Navigator.pop(context);
                                  // Here you can write your code
                                  _loadTask();
                                });
                              }
                            },
                            builder: (context, state) {
                              return ToDoListCallbackTile(
                                taskModel: task,
                                onDeletePressed: () async {
                                  await _deleteTask(task.id);
                                },
                                onPressed: () async {
                                  await DialogBox.onAddTaskPressed(context,
                                      existingTask: task,
                                      updateStateCallback: _loadTask);
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // void _onAddTaskPressed(BuildContext context, {TaskModel? existingTask}) {
  //   String taskName = existingTask?.taskName ?? '';
  //   String description = existingTask?.description ?? '';
  //   String category = existingTask?.category ?? '';
  //   String status = existingTask?.status ?? 'Pending';
  //   DateTime tempDate = existingTask?.startDate == null
  //       ? DateTime.now()
  //       : DateFormat("yyyy-MM-dd").parse(existingTask?.startDate);
  //   DateTime startDate = tempDate;
  //   DateTime tempDate1 = existingTask?.endDate == null
  //       ? DateTime.now()
  //       : DateFormat("yyyy-MM-dd").parse(existingTask?.endDate);
  //   DateTime endDate = tempDate1;
  //   TimeOfDay startTime = existingTask?.startTime == null
  //       ? TimeOfDay.now()
  //       : parseTimeStringToTimeOfDay(existingTask?.startTime);
  //   TimeOfDay endTime = existingTask?.startTime == null
  //       ? TimeOfDay.now()
  //       : parseTimeStringToTimeOfDay(existingTask?.endTime);
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(existingTask == null ? 'Add Task' : 'Update Task'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Task Name'),
  //                 onChanged: (value) {
  //                   taskName = value;
  //                 },
  //                 controller: TextEditingController(text: taskName),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Description'),
  //                 onChanged: (value) {
  //                   description = value;
  //                 },
  //                 controller: TextEditingController(text: description),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Task Category'),
  //                 onChanged: (value) {
  //                   category = value;
  //                 },
  //                 controller: TextEditingController(text: category),
  //               ),
  //               TextField(
  //                 decoration: InputDecoration(labelText: 'Task Status'),
  //                 onChanged: (value) {
  //                   status = value;
  //                 },
  //                 controller: TextEditingController(text: status),
  //               ),
  //               ListTile(
  //                 title: Text('Start Date'),
  //                 subtitle: Text('${startDate.toLocal()}'.split(' ')[0]),
  //                 onTap: () async {
  //                   DateTime? pickedDate = await showDatePicker(
  //                     context: context,
  //                     initialDate: startDate,
  //                     firstDate: DateTime.now(),
  //                     lastDate: DateTime(2101),
  //                   );
  //                   if (pickedDate != null && pickedDate != startDate)
  //                     setState(() {
  //                       startDate = pickedDate;
  //                     });
  //                 },
  //               ),
  //               ListTile(
  //                 title: Text('End Date'),
  //                 subtitle: Text('${endDate.toLocal()}'.split(' ')[0]),
  //                 onTap: () async {
  //                   DateTime? pickedDate = await showDatePicker(
  //                     context: context,
  //                     initialDate: endDate,
  //                     firstDate: DateTime.now(),
  //                     lastDate: DateTime(2101),
  //                   );
  //                   if (pickedDate != null && pickedDate != endDate)
  //                     setState(() {
  //                       endDate = pickedDate;
  //                     });
  //                 },
  //               ),
  //               ListTile(
  //                 title: Text('Start Time'),
  //                 subtitle: Text('${startTime.format(context)}'),
  //                 onTap: () async {
  //                   TimeOfDay? pickedTime = await showTimePicker(
  //                     context: context,
  //                     initialTime: startTime,
  //                   );
  //                   if (pickedTime != null && pickedTime != startTime)
  //                     setState(() {
  //                       startTime = pickedTime.replacing();
  //                     });
  //                 },
  //               ),
  //               ListTile(
  //                 title: Text('End Time'),
  //                 subtitle: Text('${endTime.format(context)}'),
  //                 onTap: () async {
  //                   TimeOfDay? pickedTime = await showTimePicker(
  //                     context: context,
  //                     initialTime: endTime,
  //                   );
  //                   if (pickedTime != null && pickedTime != endTime)
  //                     setState(() {
  //                       endTime = pickedTime.replacing();
  //                     });
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               TaskModel task = TaskModel(
  //                 id: existingTask?.id,
  //                 taskName: taskName,
  //                 description: description,
  //                 category: category,
  //                 status: status,
  //                 startDate: startDate.toString(),
  //                 endDate: endDate.toString(),
  //                 startTime: startTime.toString(),
  //                 endTime: endTime.toString(),
  //               );
  //
  //               if (existingTask == null) {
  //                 int? taskId = await _databaseHelper.insertTask(task);
  //                 print('Task added to the database with ID: $taskId');
  //               } else {
  //                 await _databaseHelper.updateTask(task);
  //                 print('Task updated in the database with ID: ${task.id}');
  //               }
  //
  //               _loadTasks();
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(existingTask == null ? 'Add' : 'Update'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  TimeOfDay parseTimeStringToTimeOfDay(String timeString) {
    List<String> timeComponents = timeString.split(':');
    int hour = int.parse(timeComponents[0].substring(10, 12));
    int minute = int.parse(timeComponents[1].substring(0, 2));
    return TimeOfDay(hour: hour, minute: minute);
  }
}
