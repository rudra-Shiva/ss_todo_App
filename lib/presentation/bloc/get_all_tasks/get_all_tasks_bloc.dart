
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/usecases/task/get_all_tasks.dart';
import 'package:todo_app/usecases/usecases.dart';

part 'get_all_tasks_event.dart';
part 'get_all_tasks_state.dart';

class GetAllTasksBloc extends Bloc<GetAllTasksEvent, GetAllTasksState> {
  late GetAllTasksUseCase _getAllTasksUseCase;
  GetAllTasksBloc() : super(GetAllTasksInitial()) {
    _getAllTasksUseCase = getInstance<GetAllTasksUseCase>();
    on<GetAllTasksEvent>((event, emit) async{
      emit(GetAllTaskLoading());
      await Future.delayed(const Duration(milliseconds: 2000), () {
      });
      if(event is GetAllTasksLoadingEvent){
        var result = await _getAllTasksUseCase.call(NoParams());
        result.fold(
                (l) => emit(GetAllTaskFailure(message: "$l")),
                (r) {
                  emit(GetAllTaskSuccess(r));
                }
        );
      }

    });
  }
}
