/// id : "id"
/// taskName : "taskName"
/// description : "description"
/// category : "category"
/// status : "status"
/// startDate : "startDate"
/// endDate : "endDate"
/// startTime : "startTime"
/// endTime : "endTime"

class TaskDataModel {
  TaskDataModel({
      this.id,
      this.taskName, 
      this.description, 
      this.category, 
      this.status, 
      this.startDate, 
      this.endDate, 
      this.startTime, 
      this.endTime,});

  TaskDataModel.fromJson(dynamic json) {
    id = json['id'];
    taskName = json['taskName'];
    description = json['description'];
    category = json['category'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }
  String? id;
  String? taskName;
  String? description;
  String? category;
  String? status;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
TaskDataModel copyWith({  String? id,
  String? taskName,
  String? description,
  String? category,
  String? status,
  String? startDate,
  String? endDate,
  String? startTime,
  String? endTime,
}) => TaskDataModel(  id: id ?? this.id,
  taskName: taskName ?? this.taskName,
  description: description ?? this.description,
  category: category ?? this.category,
  status: status ?? this.status,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  startTime: startTime ?? this.startTime,
  endTime: endTime ?? this.endTime,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['taskName'] = taskName;
    map['description'] = description;
    map['category'] = category;
    map['status'] = status;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    return map;
  }

}