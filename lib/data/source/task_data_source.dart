
import 'package:todo_app/domain/entity/task/task_model.dart';

abstract class TaskDataSource{
  Future<TaskModel> postNewTask(TaskModel task);
  Future<List<TaskModel>> getAllTask();
  Future<int?> deleteTaskById(int taskId);
  Future<List<TaskModel>> getTaskByStatus(String status);
  Future<List<TaskModel>> getSpecificCategoryTask(String category);
  Future<int?> getTotalTasksForCategoryAndStatus(String category, String status);
}