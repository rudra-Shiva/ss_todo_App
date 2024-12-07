import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';
import 'package:todo_app/domain/repository/user_repository/user_repository.dart';
import 'package:todo_app/usecases/usecases.dart';

class RegisterUserUseCases extends UseCase1<dynamic, UserEntity>{
  final UserRepository userRepository;

  RegisterUserUseCases(this.userRepository);



  @override
  Future<Either<String, dynamic>> call(UserEntity params) async{
    return await userRepository.createUser(params);
  }

}