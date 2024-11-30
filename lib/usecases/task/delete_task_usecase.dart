import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';
import 'package:todo_app/domain/repository/task_repository/task_repository.dart';
import 'package:todo_app/usecases/usecases.dart';

class DeleteTaskUseCase extends UseCase<dynamic, int>{
  final TaskRepository taskRepository;

  DeleteTaskUseCase(this.taskRepository);
  @override
  Future<Either<AppError, dynamic>> call(int params) async{
    return await taskRepository.deleteTaskById(params);
  }

}

