import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/common/db_helper/db_helper.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/presentation/bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/presentation/journey/util/flutter_toast.dart';


class CustomDialogAddBox extends StatefulWidget {
  final TaskModel? existingTask;
  final Future<void> Function()? updateStateCallback;

  const CustomDialogAddBox(
      {super.key, this.existingTask, this.updateStateCallback});

  @override
  State<CustomDialogAddBox> createState() => _CustomDialogAddBoxState();
}

class _CustomDialogAddBoxState extends State<CustomDialogAddBox> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late final AddTaskBloc _addTaskBloc;
  String taskName = '';
  String description = '';
  String category = '';
  String status = 'Pending';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _addTaskBloc = getInstance<AddTaskBloc>();
    taskName = widget.existingTask?.taskName ?? '';
    description = widget.existingTask?.description ?? '';
    category = widget.existingTask?.category ?? '';
    status = widget.existingTask?.status ?? 'Pending';
    startDate = widget.existingTask?.startDate == null
        ? DateTime.now()
        : DateFormat("yyyy-MM-dd").parse(widget.existingTask?.startDate);
    endDate = widget.existingTask?.endDate == null
        ? DateTime.now()
        : DateFormat("yyyy-MM-dd").parse(widget.existingTask?.endDate);
    startTime = widget.existingTask?.startTime == null
        ? TimeOfDay.now()
        : parseTimeStringToTimeOfDay(widget.existingTask?.startTime);
    endTime = widget.existingTask?.startTime == null
        ? TimeOfDay.now()
        : parseTimeStringToTimeOfDay(widget.existingTask?.endTime);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Task Name'),
              onChanged: (value) {
                taskName = value;
              },
              controller: TextEditingController(text: taskName),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                description = value;
              },
              controller: TextEditingController(text: description),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Task Category'),
              onChanged: (value) {
                category = value;
              },
              controller: TextEditingController(text: category),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Task Status'),
              onChanged: (value) {
                status = value;
              },
              controller: TextEditingController(text: status),
            ),
            ListTile(
              title: const Text('Start Date'),
              subtitle: Text('${startDate.toLocal()}'.split(' ')[0]),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != startDate) {
                  setState(() {
                    startDate = pickedDate;
                  });
                }
              },
            ),
            ListTile(
              title: const Text('End Date'),
              subtitle: Text('${endDate.toLocal()}'.split(' ')[0]),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: endDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != endDate) {
                  setState(() {
                    endDate = pickedDate;
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(startTime.format(context)),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: startTime,
                );
                if (pickedTime != null && pickedTime != startTime) {
                  setState(() {
                    startTime = pickedTime.replacing();
                  });
                }
              },
            ),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text(endTime.format(context)),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: endTime,
                );
                if (pickedTime != null && pickedTime != endTime) {
                  setState(() {
                    endTime = pickedTime.replacing();
                  });
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print(widget.updateStateCallback);
                    widget.updateStateCallback!;
                  },
                  child: const Text('Cancel'),
                ),
                BlocConsumer<AddTaskBloc, AddTaskState>(
                  listener: (context, state) {
                    if(state is AddTaskProgress){
                      const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if(state is AddTaskFinal){
                      ToastMessage().showToast("Task added Successfully");
                    }
                    else if(state is AddTaskFailure){
                      ToastMessage().showToast("Something went wrong");
                    }
                  },
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () async {
                        TaskModel task = TaskModel(
                          id: widget.existingTask?.id,
                          taskName: taskName,
                          description: description,
                          category: category,
                          status: status,
                          startDate: startDate.toString(),
                          endDate: endDate.toString(),
                          startTime: startTime.toString(),
                          endTime: endTime.toString(),
                        );

                        if (widget.existingTask == null) {
                          BlocProvider.of<AddTaskBloc>(context).add(
                            AddTaskSubmitEvent(
                                TaskModel(
                                  id: widget.existingTask?.id,
                                  taskName: taskName,
                                  description: description,
                                  category: category,
                                  status: status,
                                  startDate: startDate.toString(),
                                  endDate: endDate.toString(),
                                  startTime: startTime.toString(),
                                  endTime: endTime.toString(),
                                )
                            )
                          );
                          // int? taskId = await _databaseHelper.insertTask(task);
                          if (kDebugMode) {
                            print(
                                'Task added to the database with ID: testing');
                          }
                        } else {
                          await _databaseHelper.updateTask(task);
                          print('Task updated in the database with ID: ${task
                              .id}');
                        }

                        // Call the callback to update the state
                        Navigator.of(context).pop();
                        widget.updateStateCallback!();
                      },
                      child: Text(
                          widget.existingTask == null ? 'Add' : 'Update'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //parsing string time into time format
  TimeOfDay parseTimeStringToTimeOfDay(String timeString) {
    List<String> timeComponents = timeString.split(':');

    int hour = int.parse(timeComponents[0].substring(10, 12));
    print(hour);
    int minute = int.parse(timeComponents[1].substring(0, 2));

    return TimeOfDay(hour: hour, minute: minute);
  }
}
