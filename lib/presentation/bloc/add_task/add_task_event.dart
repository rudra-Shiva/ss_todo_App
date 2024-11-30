part of 'add_task_bloc.dart';

@immutable
abstract class AddTaskEvent {}

class AddTaskSubmitEvent extends AddTaskEvent{
  final TaskModel taskModel;

  AddTaskSubmitEvent(this.taskModel);

}
