import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';
import 'package:todo_app/common/ui/widgets/ToDoListCallbackTile.dart';
import 'package:todo_app/common/ui/widgets/dialog_box/dialog_box.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:todo_app/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:todo_app/presentation/journey/util/flutter_toast.dart';

final GlobalKey<AnimatedCircularChartState> _chartKey =
    GlobalKey<AnimatedCircularChartState>();

class AllTaskView extends StatefulWidget {
  const AllTaskView({super.key});

  @override
  State<AllTaskView> createState() => _AllTaskViewState();
}

class _AllTaskViewState extends State<AllTaskView> {
  late GetAllTasksBloc _getAllTasksBloc;
  late DeleteTaskBloc _deleteTaskBloc;

  @override
  void initState() {
    super.initState();
    _getAllTasksBloc = getInstance<GetAllTasksBloc>();
    if (!_getAllTasksBloc.isClosed) {
      _getAllTasksBloc.add(GetAllTasksLoadingEvent());
    }
    _deleteTaskBloc = getInstance<DeleteTaskBloc>();
  }

  Future<void> _loadTask() async {
    if (!_getAllTasksBloc.isClosed) {
      _getAllTasksBloc.add(GetAllTasksLoadingEvent());
    }
  }

  Future<void> _deleteTask(int taskId) async {
    if (!_deleteTaskBloc.isClosed) {
      _deleteTaskBloc.add(DeleteEventInitiated(taskId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _getAllTasksBloc),
        BlocProvider.value(value: _deleteTaskBloc)
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: Dimen.dimen_200.h,
              decoration: BoxDecoration(
                  color: AppColor.taskCategorySchool,
                  border: Border.all(
                    color: AppColor.taskStatusBorderSchool,
                  ),
                  borderRadius: BorderRadius.circular(
                      20) // use instead of BorderRadius.all(Radius.circular(20))
                  ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimen.dimen_10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "All Task",
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
                    child: Row(
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
                                  "2/4",
                                  style: AppStyle.textStyle14(
                                      color: AppColor.white),
                                )
                              ],
                            )
                          ],
                        ),
                        AnimatedCircularChart(
                          key: _chartKey,
                          size: const Size(160.0, 160.0),
                          initialChartData: <CircularStackEntry>[
                            CircularStackEntry(
                              <CircularSegmentEntry>[
                                CircularSegmentEntry(
                                  50,
                                  Colors.blue[400],
                                  rankKey: 'completed',
                                ),
                                CircularSegmentEntry(
                                  50,
                                  Colors.blueGrey[600],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],
                          chartType: CircularChartType.Radial,
                          percentageValues: true,
                          holeLabel: '2/4',
                          labelStyle: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimen.dimen_20.sp,
                          ),
                        )
                      ],
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
            BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
              builder: (context, state) {
                if (_getAllTasksBloc.state is GetAllTaskLoading) {
                  return SizedBox(
                    height: ScreenUtil().screenHeight - 320.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GetAllTaskFailure) {
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
                } else if (state is GetAllTaskSuccess) {
                  return SizedBox(
                    height: ScreenUtil().screenHeight - 320.h,
                    child: ListView.builder(
                      itemCount: state.taskDataModel.length,
                      itemBuilder: (context, index) {
                        TaskModel task = state.taskDataModel[index];
                        if (state.taskDataModel.isEmpty) {
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
