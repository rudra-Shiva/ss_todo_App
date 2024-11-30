import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'custom_dialog_add_task_bloc.dart';
import 'custom_dialog_box.dart';

class DialogBox {
  final BuildContext context;
  final VoidCallback? updateStateCallback;

  DialogBox({required this.context,  this.updateStateCallback});

  static Future<void> onAddTaskPressed(BuildContext context, {TaskModel? existingTask,  final Future<void> Function()? updateStateCallback}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(existingTask == null ? 'Add Task' : 'Update Task'),
          content: CustomDialogBox(existingTask: existingTask,   updateStateCallback: updateStateCallback),
        );
      },
    );
  }

  static Future<void> onAddTaskPressedUsingBloc(BuildContext context, {TaskModel? existingTask,  final Future<void> Function()? updateStateCallback}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(existingTask == null ? 'Add Task' : 'Update Task'),
          content: SizedBox(
            width: Dimen.dimen_400.w,
              child: CustomDialogAddBox(existingTask: existingTask,   updateStateCallback: updateStateCallback)),
        );
      },
    );
  }

  // void _onAddTaskPressed(BuildContext context, Function() updateStateCallback,
  //     {Task? existingTask}) {
  //   final DatabaseHelper _databaseHelper = DatabaseHelper();
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
  //               Task task = Task(
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
  //               updateStateCallback(); // Call the callback to update the state
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(existingTask == null ? 'Add' : 'Update'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //parsing string time into time format
  TimeOfDay parseTimeStringToTimeOfDay(String timeString) {
    List<String> timeComponents = timeString.split(':');

    int hour = int.parse(timeComponents[0].substring(10, 12));
    print(hour);
    int minute = int.parse(timeComponents[1].substring(0, 2));

    return TimeOfDay(hour: hour, minute: minute);
  }
}
