import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/common/db_helper/db_helper_ab.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';


class DatabaseHelper extends DbHelperAb {
  static Database? _database;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  @override
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskName TEXT,
            description TEXT,
            category TEXT,
            status TEXT,
            startDate TEXT,
            endDate TEXT,
            startTime TEXT,
            endTime TEXT,
            isSynced INTEGER DEFAULT 0 -- 0: Not Synced, 1: Synced
          )
        ''');
      },
    );
  }

  // @override
  // Future<int?> insertTask(TaskModel task) async {
  //   Database? db = await database;
  //
  //   return await db?.insert('tasks', task.toMap());
  // }
  // Insert Task into Local Database and Sync with Firebase
  @override
  Future<int?> insertTask(TaskModel task) async {
    Database? db = await database;

    int? taskId = await db?.insert('tasks', task.toMap());
    if (taskId != null) {
      task = task.copyWith(id: taskId);
      await _syncTaskToFirebase(task);
    }

    return taskId;
  }
  // Sync Single Task to Firebase
  Future<void> _syncTaskToFirebase(TaskModel task) async {
    try {
      await _firestore.collection('tasks').doc(task.id.toString()).set(task.toMap());
      _markTaskAsSynced(task.id!);
    } catch (e) {
      print("Error syncing task to Firebase: $e");
    }
  }
  // Mark Task as Synced in Local Database
  Future<void> _markTaskAsSynced(int taskId) async {
    Database? db = await database;
    await db?.update(
      'tasks',
      {'isSynced': 1},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
  // Sync All Unsynced Tasks to Firebase
  Future<void> syncUnsyncedTasks() async {
    Database? db = await database;

    List<Map<String, dynamic>>? unsyncedTasks = await db?.query(
      'tasks',
      where: 'isSynced = ?',
      whereArgs: [0],
    );

    if (unsyncedTasks != null) {
      for (var taskMap in unsyncedTasks) {
        TaskModel task = TaskModel.fromMap(taskMap);
        await _syncTaskToFirebase(task);
      }
    }
  }
  // Fetch Tasks from Firebase and Update Local Database
  Future<void> fetchTasksFromFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('tasks').get();

      for (var doc in snapshot.docs) {
        TaskModel task = TaskModel.fromMap(doc.data());
        await insertOrUpdateLocalTask(task);
      }
    } catch (e) {
      print("Error fetching tasks from Firebase: $e");
    }
  }

  // Insert or Update Local Task from Firebase
  Future<void> insertOrUpdateLocalTask(TaskModel task) async {
    Database? db = await database;

    List<Map<String, dynamic>>? existingTasks = await db?.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );

    if (existingTasks != null && existingTasks.isNotEmpty) {
      await db?.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } else {
      await db?.insert('tasks', task.toMap());
    }
  }


  //get all tasks
  @override
  Future<List<TaskModel>> getAllTasks() async {
    Database? db = await database;
    List<Map<String, Object?>>? maps = await db?.query('tasks',orderBy: 'startDate asc');
    if(maps!.isEmpty){
      return [];
    }else {
      return List.generate(maps.length, (index) {
        return TaskModel(
          id: maps[index]['id'],
          taskName: maps[index]['taskName'].toString(),
          description: maps[index]['description'].toString(),
          category: maps[index]['category'].toString(),
          status: maps[index]['status'].toString(),
          startDate: maps[index]['startDate'].toString(),
          endDate: maps[index]['endDate'].toString(),
          startTime: maps[index]['startTime'].toString(),
          endTime: maps[index]['endTime'].toString(),
        );
      });
    }
  }

  //task with status on going
  @override
  Future<List<TaskModel>?> getOngoingTasksLimitedByDate(DateTime currentDate, int limit) async {
    Database? db = await database;

    // Construct the SQL query to fetch ongoing tasks with a limit and date filter
    String query = '''
      SELECT * FROM tasks 
      WHERE status = 'Ongoing' 
      ORDER BY startDate asc
      LIMIT ?
    ''';

    List<Map<String, Object?>>? result = await db?.rawQuery(query, [
      // currentDate.toIso8601String(),
      limit,
    ]);

    // Convert the result into a list of Task objects
    List<TaskModel>? tasks = result?.map((taskMap) => TaskModel.fromMap(taskMap)).toList();

    return tasks;
  }
  @override
  Future<int?> getTotalTasksForCategory(String category) async {
    Database? db = await database;

    // Construct the SQL query to get the count of tasks for the specified category
    String query = '''
      SELECT COUNT(*) as count FROM tasks WHERE category = ?
    ''';

    List<Map<String, Object?>>? result = await db?.rawQuery(query, [category]);

    // Extract the count from the result
    int? taskCount = (result!.isNotEmpty ? result.first['count'] : 0) as int?;

    return taskCount;
  }

  // For future update
  @override
  Future<int?> updateTask(TaskModel task) async {
    Database? db = await database;

    return await db?.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id], // assuming 'id' is the primary key of your 'tasks' table
    );
  }
  // For Future Delete
  @override
  Future<int?> deleteTaskById(int taskId) async {
    Database? db = await database;
    await db?.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
    return taskId;
  }

  //get task by status
  @override
  Future<List<TaskModel>> getTasksByStatus(String status) async {
    Database? db = await database;
    List<Map<String, Object?>>? maps =
    await db?.query('tasks', where: 'status = ?', whereArgs: [status]);
    // List<TaskModel>? tasks = maps?.map((taskMap) => TaskModel.fromMap(taskMap)).toList();
    List<TaskModel>? taskByStatus = maps?.map((e) => TaskModel.fromMap(e)).toList();
    //for understanding purpose
    // return List.generate(maps!.length, (index) {
    //   return TaskModel(
    //     id: maps[index]['id'],
    //     taskName: maps[index]['taskName'].toString(),
    //     description: maps[index]['description'].toString(),
    //     category: maps[index]['category'].toString(),
    //     status: maps[index]['status'].toString(),
    //     startDate: maps[index]['startDate'].toString(),
    //     endDate: maps[index]['endDate'].toString(),
    //     startTime: maps[index]['startTime'].toString(),
    //     endTime: maps[index]['endTime'].toString(),
    //   );
    // });
    return taskByStatus ?? [];
  }

  //get task by status
  @override
  Future<List<TaskModel>> getTasksByCategory(String category) async {
    Database? db = await database;
    List<Map<String, Object?>>? maps =
    await db?.query('tasks', where: 'category = ?', whereArgs: [category]);
    // List<TaskModel>? tasks = maps?.map((taskMap) => TaskModel.fromMap(taskMap)).toList();
    List<TaskModel>? taskByStatus = maps?.map((e) => TaskModel.fromMap(e)).toList();

    return taskByStatus ?? [];
  }

  //for getting no of task category and status wise
  @override
  Future<int?> getTotalTasksForCategoryAndStatus(String category, String status) async {
    Database? db = await database;

    // Construct the SQL query to get the count of tasks for the specified category and status
    String query = '''
    SELECT COUNT(*) as count FROM tasks WHERE category = ? AND status = ?
  ''';

    List<Map<String, Object?>>? result = await db?.rawQuery(query, [category, status]);

    // Extract the count from the result
    int? taskCount = (result!.isNotEmpty ? result.first['count'] : 0) as int?;

    return taskCount;
  }


}