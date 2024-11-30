// To parse this JSON data, do
//
//     final task = taskFromMap(jsonString);

import 'dart:convert';

TaskData taskFromMap(String str) => TaskData.fromMap(json.decode(str));

String taskToMap(TaskData data) => json.encode(data.toMap());

class TaskData {
  dynamic id;
  String? taskName;
  String? description;
  String? category;
  String? status;
  dynamic startDate;
  dynamic endDate;
  dynamic startTime;
  dynamic endTime;

  TaskData({
    this.id,
    this.taskName,
    this.description,
    this.category,
    this.status,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
  });

  TaskData copyWith({
    dynamic id,
    String? taskName,
    String? description,
    String? category,
    String? status,
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
  }) =>
      TaskData(
        id: id ?? this.id,
        taskName: taskName ?? this.taskName,
        description: description ?? this.description,
        category: category ?? this.category,
        status: status ?? this.status,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );

  factory TaskData.fromMap(Map<String, dynamic> json) => TaskData(
    id: json["id"],
    taskName: json["taskName"],
    description: json["description"],
    category: json["category"],
    status: json["status"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "taskName": taskName,
    "description": description,
    "category": category,
    "status": status,
    "startDate": startDate,
    "endDate": endDate,
    "startTime": startTime,
    "endTime": endTime,
  };
}
