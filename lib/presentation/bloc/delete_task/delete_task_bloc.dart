import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/usecases/task/delete_task_usecase.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  late DeleteTaskUseCase deleteTaskUseCase;
  DeleteTaskBloc() : super(DeleteTaskInitial()) {
    deleteTaskUseCase = getInstance<DeleteTaskUseCase>();
    on<DeleteTaskEvent>((event, emit) async{
      emit(DeleteTaskInitial());
      if(event is DeleteEventInitiated){
        var result = await deleteTaskUseCase.call(event.taskId);
        result.fold(
                (l) => emit(DeleteTaskFailed(message: "Failed to delete task $l ")),
                (r) => emit(DeleteTaskSuccess(r)));
      }
    });
  }
}

