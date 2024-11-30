part of 'get_all_tasks_bloc.dart';

@immutable
abstract class GetAllTasksState {
  const GetAllTasksState();
}

class GetAllTasksInitial extends GetAllTasksState {}

class GetAllTaskLoading extends GetAllTasksState{}

class GetAllTaskSuccess extends GetAllTasksState{
  final List<TaskModel> taskDataModel;
  const GetAllTaskSuccess(this.taskDataModel);
}

class GetAllTaskFailure extends GetAllTasksState{
  final String? message;
  const GetAllTaskFailure({this.message});
}
