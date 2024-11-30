part of 'delete_task_bloc.dart';

@immutable
abstract class DeleteTaskEvent {}

class DeleteEventInitiated extends DeleteTaskEvent{
 final int taskId;

  DeleteEventInitiated(this.taskId);
}
