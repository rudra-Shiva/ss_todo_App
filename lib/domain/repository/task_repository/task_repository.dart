import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/domain/entity/app_error/app_error.dart';

abstract class TaskRepository{
  Future<Either<AppError, TaskModel>> addNewTask(TaskModel task);
  Future<Either<AppError, List<TaskModel>>> getAllTask();
  Future<Either<AppError, TaskModel>> getTaskBYId();
  Future<Either<AppError, int>> deleteTaskById(int taskId);
  Future<Either<AppError, List<TaskModel>>> getTaskByStatus(String status);
  Future<Either<AppError, List<TaskModel>>> getSpecificCategoryTask(String category);
  Future<Either<AppError, int>> getTotalTasksForCategoryAndStatus(String category, String status);
}