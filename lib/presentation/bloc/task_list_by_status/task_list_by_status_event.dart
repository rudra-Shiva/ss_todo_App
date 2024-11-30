part of 'task_list_by_status_bloc.dart';

@immutable
abstract class TaskListByStatusEvent {}

class TaskListByStatusInitialEvent extends TaskListByStatusEvent{

}

class TaskListByStatusFinalEvent extends TaskListByStatusEvent{
  final String taskStatus;
  TaskListByStatusFinalEvent(this.taskStatus);
}

