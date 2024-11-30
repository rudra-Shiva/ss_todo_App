import 'package:todo_app/common/db_helper/db_helper.dart';
import 'package:todo_app/common/db_helper/db_helper_ab.dart';
import 'package:todo_app/common/exception/app_exception.dart';
import 'package:todo_app/data/source/task_data_source.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';

class TaskDataSourceImpl extends TaskDataSource {
  final DbHelperAb databaseHelper = getInstance<DbHelperAb>();

  @override
  Future<TaskModel> postNewTask(TaskModel task) async {
    try {
      int? taskId = await databaseHelper.insertTask(task);

      if (taskId != null) {
        // Assuming your Task class has an 'id' field
        task = task.copyWith(id: taskId);
        return task;
      } else {
        throw AppException('Failed to post new task to the local database.');
      }
    } catch (e) {
      throw AppException('Failed to post new task: $e');
    }
  }

  @override
  Future<List<TaskModel>> getAllTask() async {
    try {
      List<TaskModel> tasks = await databaseHelper.getAllTasks();
      // List<TaskDataModel> allTaskList =
      //     tasks.map((e) => TaskDataModel.fromJson(e)).toList();
      return tasks;
    } catch (e) {
      throw AppException('Failed to fetch all tasks: $e');
    }
  }

  @override
  Future<int?> deleteTaskById(int taskId) async{
    try {
      int? tasks = await databaseHelper.deleteTaskById(taskId);
      // List<TaskDataModel> allTaskList =
      //     tasks.map((e) => TaskDataModel.fromJson(e)).toList();
      return tasks;
    } catch (e) {
      throw AppException('Failed to fetch all tasks: $e');
    }
  }

  @override
  Future<List<TaskModel>> getTaskByStatus(String status) async {
    try {
      List<TaskModel> tasks = await databaseHelper.getTasksByStatus(status);
      return tasks;
    } catch (e) {
      throw AppException('Failed to fetch all tasks: $e');
    }
  }

  @override
  Future<List<TaskModel>> getSpecificCategoryTask(String category) async{
    try{
      List<TaskModel> tasks = await databaseHelper.getTasksByCategory(category);
      return tasks;
    }catch(e){
      throw AppException("Failed to fetch all tasks: $e");
    }
  }

  @override
  Future<int?> getTotalTasksForCategoryAndStatus(String category, String status) async{
    try{
      int?  tasksCount = await databaseHelper.getTotalTasksForCategoryAndStatus(category, status);
      return tasksCount;
    }catch(e){
      throw AppException("Failed to fetch total count of tasks: $e");
    }
  }

}
