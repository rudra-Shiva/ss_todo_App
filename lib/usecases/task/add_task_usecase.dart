import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/domain/repository/task_repository/task_repository.dart';
import 'package:todo_app/usecases/usecases.dart';

class AddTaskUseCases extends UseCase<dynamic, TaskModel>{
  final TaskRepository taskRepository;

  AddTaskUseCases(this.taskRepository);

  @override
  Future<Either<AppError, dynamic>> call(TaskModel params) async{
    return await taskRepository.addNewTask(params);
  }

}