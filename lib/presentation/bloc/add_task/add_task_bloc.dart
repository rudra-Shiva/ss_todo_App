
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/usecases/task/add_task_usecase.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  late AddTaskUseCases _addTaskUseCases;

  AddTaskBloc() : super(AddTaskInitial()) {
    _addTaskUseCases = getInstance<AddTaskUseCases>();
    on<AddTaskEvent>((event, emit) async {
      if(event is AddTaskSubmitEvent){
        emit(AddTaskProgress());
        final response = await _addTaskUseCases.call(event.taskModel);
        response.fold(
                (l) => emit(AddTaskFailure(message: l.message)),
                (r) => emit(AddTaskFinal(r))
        );
      }
    });
  }
}
