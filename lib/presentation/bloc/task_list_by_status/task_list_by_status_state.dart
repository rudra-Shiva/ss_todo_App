part of 'task_list_by_status_bloc.dart';

@immutable
abstract class TaskListByStatusState {
  const TaskListByStatusState();
}

class TaskListByStatusInitial extends TaskListByStatusState {}

class TaskListByStatusProgress extends TaskListByStatusState {}

class TaskListByStatusSuccess extends TaskListByStatusState {
  final List<TaskModel> listByStatus;
  const TaskListByStatusSuccess(this.listByStatus);
}

class TaskListByStatusFailed extends TaskListByStatusState {
  final String? message;
  const TaskListByStatusFailed({this.message});
}
