import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';
import 'package:todo_app/usecases/user/register_user_usecase.dart';

part 'todo_register_event.dart';
part 'todo_register_state.dart';

class TodoRegisterBloc extends Bloc<TodoRegisterEvent, TodoRegisterState> {
  late RegisterUserUseCases _registerUserUseCases;
  TodoRegisterBloc() : super(TodoRegisterInitial()) {
    _registerUserUseCases = getInstance<RegisterUserUseCases>();
    on<TodoRegisterEvent>((event, emit) async{
      if(event is UserRegisterEvent){
        emit(TodoRegisterProgress());
        var response = await _registerUserUseCases.call(event.user);
        response.fold(
                (l) => emit(TodoRegisterFailed(message: l)),
                (r) => emit(TodoRegisterSuccess(r))
        );
      }


    });
  }
}
