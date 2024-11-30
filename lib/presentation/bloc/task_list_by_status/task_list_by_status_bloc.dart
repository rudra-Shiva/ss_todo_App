import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/usecases/task/task_list_by_status_usecase.dart';

part 'task_list_by_status_event.dart';
part 'task_list_by_status_state.dart';

class TaskListByStatusBloc extends Bloc<TaskListByStatusEvent, TaskListByStatusState> {
  late TaskListByStatusUseCase _taskListByStatusUseCase;
  TaskListByStatusBloc() : super(TaskListByStatusInitial()) {
    _taskListByStatusUseCase = getInstance<TaskListByStatusUseCase>();
    on<TaskListByStatusEvent>((event, emit) async{
      if(event is TaskListByStatusInitialEvent){
        emit(TaskListByStatusInitial());
      }
      if(event is TaskListByStatusFinalEvent){
        emit(TaskListByStatusProgress());
        var result = await _taskListByStatusUseCase.call(event.taskStatus);
        result.fold(
                (l) => emit(TaskListByStatusFailed(message:l.toString())),
                (r) => emit(TaskListByStatusSuccess(r))
        );
      }
    });
  }
}
