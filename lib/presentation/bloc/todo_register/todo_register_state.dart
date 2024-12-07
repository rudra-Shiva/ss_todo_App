part of 'todo_register_bloc.dart';

@immutable
sealed class TodoRegisterState {}

final class TodoRegisterInitial extends TodoRegisterState {}

final class TodoRegisterProgress extends TodoRegisterState {}

final class TodoRegisterSuccess extends TodoRegisterState {
  final UserEntity user;

  TodoRegisterSuccess(this.user);
}

final class TodoRegisterFailed extends TodoRegisterState {
  final String? message;

  TodoRegisterFailed({this.message});

}
