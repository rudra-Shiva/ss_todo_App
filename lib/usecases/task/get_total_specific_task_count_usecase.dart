import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';
import 'package:todo_app/domain/repository/task_repository/task_repository.dart';
import 'package:todo_app/usecases/usecases.dart';

class GetTotalSpecificTaskCountUseCase extends UseCaseTask<int, String>{
  final TaskRepository _taskRepository;
  GetTotalSpecificTaskCountUseCase(this._taskRepository);
  @override
  Future<Either<AppError, int>> call(String params, String param) async{
    return await _taskRepository.getTotalTasksForCategoryAndStatus(params, param);
  }

}