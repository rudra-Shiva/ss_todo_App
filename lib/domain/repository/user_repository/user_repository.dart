import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';

abstract class UserRepository{
  Future<Either<String,UserEntity>> createUser(UserEntity user);
  Future<UserEntity?> getUserById(String id);
  Future<List<UserEntity>> getAllUsers();
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser(String id);
}