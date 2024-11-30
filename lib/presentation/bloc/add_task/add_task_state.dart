part of 'add_task_bloc.dart';

@immutable
abstract class AddTaskState {
  const AddTaskState();
}

class AddTaskInitial extends AddTaskState {}

class AddTaskProgress extends AddTaskState{}

class AddTaskFinal extends AddTaskState{
  final TaskModel taskModel;

  const AddTaskFinal(this.taskModel);

}

class AddTaskFailure extends AddTaskState{
  final String? message;

  const AddTaskFailure({this.message});

}