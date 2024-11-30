import 'package:dartz/dartz.dart';
import 'package:todo_app/common/exception/app_exception.dart';
import 'package:todo_app/data/source/task_data_source.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/domain/repository/task_repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository{
  final TaskDataSource taskDataSourceImpl = getInstance<TaskDataSource>();

  @override
  Future<Either<AppError, TaskModel>> addNewTask(TaskModel task) async{
    try{
        var addTask = await taskDataSourceImpl.postNewTask(task);
        return Right(addTask);
    }on AppException catch(ex){
      return Left(AppError(AppErrorType.database, message: ex.message));
    }
  }

  @override
  Future<Either<AppError, int>> deleteTaskById(int taskId) async {
    try {
      // Assuming taskRepository.deleteTaskById returns a id on success
      final deletedTask = await taskDataSourceImpl.deleteTaskById(taskId);

      return Right(deletedTask!);
    } catch (e) {
      // Handle errors, e.g., AppException, and return an AppError
      return Left(AppError(AppErrorType.database, message: 'Failed to delete task: $e'));
    }
  }

  @override
  Future<Either<AppError, List<TaskModel>>> getAllTask() async{
    try{
      var getTask = await taskDataSourceImpl.getAllTask();
      if(getTask.isEmpty){
        return const Left(AppError(AppErrorType.database, message: "No tasks in List"));
      }
      return Right(getTask);
    } on AppException catch (ex) {
      return Left(AppError(AppErrorType.database, message: ex.message));
    }
  }

  @override
  Future<Either<AppError, TaskModel>> getTaskBYId() {
    // TODO: implement getTaskBYId
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, List<TaskModel>>> getTaskByStatus(String status) async{
    try{
      var getTask = await taskDataSourceImpl.getTaskByStatus(status);
      if(getTask.isEmpty){
        return const Left(AppError(AppErrorType.database, message: "No tasks in List"));
      }
      return Right(getTask);
    } on AppException catch (ex) {
      return Left(AppError(AppErrorType.database, message: ex.message));
    }
  }

  @override
  Future<Either<AppError, List<TaskModel>>> getSpecificCategoryTask(String category) async{
    try{
      var getTaskCategoryWise = await taskDataSourceImpl.getSpecificCategoryTask(category);
      if(getTaskCategoryWise.isEmpty){
        return const Left(AppError(AppErrorType.database,message: "No task in this Category"));
      }
      return Right(getTaskCategoryWise);
    }on AppException catch(ex){
      return Left(AppError(AppErrorType.database,message: ex.message));
    }
  }

  @override
  Future<Either<AppError, int>> getTotalTasksForCategoryAndStatus(String category, String status) async{
    try{
      int? getTaskCategoryWise = await taskDataSourceImpl.getTotalTasksForCategoryAndStatus(category, status);

      return Right(getTaskCategoryWise!);
    }on AppException catch(ex){
      return Left(AppError(AppErrorType.database,message: ex.message));
    }
  }

}