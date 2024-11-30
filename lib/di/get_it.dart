import 'package:get_it/get_it.dart';
import 'package:todo_app/common/db_helper/db_helper.dart';
import 'package:todo_app/common/db_helper/db_helper_ab.dart';
import 'package:todo_app/common/ui/widgets/dialog_box/custom_dialog_add_task_bloc.dart';
import 'package:todo_app/data/repository_impl/task_repository_impl/task_repository_impl.dart';
import 'package:todo_app/data/source/source_impl/task_data_source_impl.dart';
import 'package:todo_app/data/source/task_data_source.dart';
import 'package:todo_app/domain/repository/task_repository/task_repository.dart';
import 'package:todo_app/presentation/bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:todo_app/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:todo_app/presentation/bloc/get_total_count_specific_category_wise/get_totoal_count_specific_category_wise_bloc.dart';
import 'package:todo_app/presentation/bloc/search_task/search_bloc.dart';
import 'package:todo_app/presentation/bloc/specific_category_task/specific_category_task_bloc.dart';
import 'package:todo_app/presentation/bloc/task_list_by_status/task_list_by_status_bloc.dart';
import 'package:todo_app/usecases/task/add_task_usecase.dart';
import 'package:todo_app/usecases/task/delete_task_usecase.dart';
import 'package:todo_app/usecases/task/get_all_tasks.dart';
import 'package:todo_app/usecases/task/get_specific_category_task_usecase.dart';
import 'package:todo_app/usecases/task/task_list_by_status_usecase.dart';

final getInstance  = GetIt.I;
GetIt sl = GetIt.instance;
Future init() async{
  getInstance.registerSingleton<CustomDialogAddBox>( const CustomDialogAddBox());

  //sqlite Db instance register
  getInstance.registerLazySingleton<DbHelperAb>(() => DatabaseHelper());

  getInstance.registerLazySingleton<TaskDataSource>(() => TaskDataSourceImpl());
  getInstance.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  getInstance.registerLazySingleton<AddTaskBloc>(() => AddTaskBloc());
  getInstance.registerLazySingleton<AddTaskUseCases>(() => AddTaskUseCases(getInstance()));

  getInstance.registerLazySingleton<GetAllTasksUseCase>(() => GetAllTasksUseCase(getInstance()));
  getInstance.registerLazySingleton<GetAllTasksBloc>(() => GetAllTasksBloc());

  getInstance.registerLazySingleton<DeleteTaskUseCase>(() => DeleteTaskUseCase(getInstance()));
  getInstance.registerLazySingleton<DeleteTaskBloc>(() => DeleteTaskBloc());

  getInstance.registerLazySingleton<SearchBloc>(() => SearchBloc());

  getInstance.registerLazySingleton<TaskListByStatusUseCase>(() => TaskListByStatusUseCase(getInstance()));
  getInstance.registerLazySingleton<TaskListByStatusBloc> (() => TaskListByStatusBloc());

  getInstance.registerLazySingleton<GetSpecificCategoryTaskUseCase>(() => GetSpecificCategoryTaskUseCase(getInstance()));
  getInstance.registerLazySingleton<SpecificCategoryTaskBloc>(() => SpecificCategoryTaskBloc());

  getInstance.registerLazySingleton<GetTotalCountSpecificCategoryWiseBloc>(() => GetTotalCountSpecificCategoryWiseBloc());
}