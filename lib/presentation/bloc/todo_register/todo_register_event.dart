part of 'todo_register_bloc.dart';

@immutable
sealed class TodoRegisterEvent {}

class UserRegisterEvent extends TodoRegisterEvent {
  final UserEntity user;

  UserRegisterEvent(this.user);
}
