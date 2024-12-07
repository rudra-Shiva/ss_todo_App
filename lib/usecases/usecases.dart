import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}

 class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCaseTask<Type, Params> {
  Future<Either<AppError, Type>> call(Params params, String param);
}

abstract class UseCase1<Type, Params> {
  Future<Either<String, Type>> call(Params params);
}
