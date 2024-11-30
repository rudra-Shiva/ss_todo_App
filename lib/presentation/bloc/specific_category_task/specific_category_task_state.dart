part of 'specific_category_task_bloc.dart';

@immutable
abstract class SpecificCategoryTaskState {
  const SpecificCategoryTaskState();
}

class SpecificCategoryTaskInitial extends SpecificCategoryTaskState {}

class SpecificCategoryTaskProgress extends SpecificCategoryTaskState {}

class SpecificCategoryTaskSuccess extends SpecificCategoryTaskState {
  final List<TaskModel> taskModel;
  const SpecificCategoryTaskSuccess(this.taskModel);
}

class SpecificCategoryTaskFailed extends SpecificCategoryTaskState {
  final String? message;
  const SpecificCategoryTaskFailed({this.message});
}
