part of 'delete_task_bloc.dart';

@immutable
abstract class DeleteTaskState {
  const DeleteTaskState();
}

class DeleteTaskInitial extends DeleteTaskState {}

class DeleteTaskInitiated extends DeleteTaskState {}

class DeleteTaskSuccess extends DeleteTaskState {
  final int taskId;

  const DeleteTaskSuccess(this.taskId);
}

class DeleteTaskFailed extends DeleteTaskState {
  final String? message;

  const DeleteTaskFailed({this.message});
}
