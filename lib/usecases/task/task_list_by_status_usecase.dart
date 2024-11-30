import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/domain/repository/task_repository/task_repository.dart';
import 'package:todo_app/usecases/usecases.dart';

class TaskListByStatusUseCase extends UseCase<List<TaskModel>,String> {
  final TaskRepository _taskRepository;

  TaskListByStatusUseCase(this._taskRepository);

  @override
  Future<Either<AppError, List<TaskModel>>> call(String params) async{
    return await _taskRepository.getTaskByStatus(params);
  }
}
