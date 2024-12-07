import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_login_event.dart';
part 'todo_login_state.dart';

class TodoLoginBloc extends Bloc<TodoLoginEvent, TodoLoginState> {
  TodoLoginBloc() : super(TodoLoginInitial()) {
    on<TodoLoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
