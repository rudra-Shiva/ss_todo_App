import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/common/db_helper/db_helper.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';



class CustomDialogBox extends StatefulWidget {
  final TaskModel? existingTask;
  final Future<void> Function()? updateStateCallback;

  const CustomDialogBox(
      {super.key, this.existingTask, this.updateStateCallback});

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
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
    return SingleChildScrollView(
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
                TextButton(
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
                      int? taskId = await _databaseHelper.insertTask(task);
                      if (kDebugMode) {
                        print('Task added to the database with ID: $taskId');
                      }
                    } else {
                      await _databaseHelper.updateTask(task);
                      print('Task updated in the database with ID: ${task.id}');
                    }

                    // Call the callback to update the state
                    Navigator.of(context).pop();
                    widget.updateStateCallback!();
                  },
                  child: Text(widget.existingTask == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ],
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
