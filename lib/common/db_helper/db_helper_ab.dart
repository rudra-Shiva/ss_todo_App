import 'package:sqflite/sqflite.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';

abstract class DbHelperAb{
  Future<Database?> get database ;
  Future<Database> initDatabase();
  Future<int?> insertTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
  Future<List<TaskModel>?> getOngoingTasksLimitedByDate(DateTime currentDate, int limit);
  Future<int?> getTotalTasksForCategory(String category);
  Future<int?> updateTask(TaskModel task);
  Future<int?> deleteTaskById(int taskId);
  Future<List<TaskModel>> getTasksByStatus(String status);
  Future<List<TaskModel>> getTasksByCategory(String category);
  Future<int?> getTotalTasksForCategoryAndStatus(String category, String status);

}