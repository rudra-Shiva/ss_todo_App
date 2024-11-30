
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/usecases/task/get_specific_category_task_usecase.dart';


part 'get_totoal_count_specific_category_wise_event.dart';
part 'get_totoal_count_specific_category_wise_state.dart';

class GetTotalCountSpecificCategoryWiseBloc extends Bloc<GetTotalCountSpecificCategoryWiseEvent, GetTotalCountSpecificCategoryWiseState> {
  late GetSpecificCategoryTaskUseCase _taskCountUseCase;
  GetTotalCountSpecificCategoryWiseBloc() : super(GetTotalCountSpecificCategoryWiseInitial()) {
    _taskCountUseCase = getInstance<GetSpecificCategoryTaskUseCase>();
    on<GetTotalCountSpecificCategoryWiseEvent>((event, emit) async{
      emit(GetTotalCountProgress());
      await Future.delayed(const Duration(milliseconds: 400));
      if(event is GetTotalCountFinalEvent){
        var result = await _taskCountUseCase.call(event.category);
        result.fold(
                (l) => emit(GetTotalCountFailed(message:l.toString())),
                (r) {
                  int l_1 = countCompletedTasks(r);
                  int l_2  = r.length;
                      emit(GetTotalCountSuccess(l_2,l_1));
                }
        );
      }
    });
  }
  int countCompletedTasks(List<TaskModel> tasks) {
    // Filter the list to include only completed tasks
    List<TaskModel> completedTasks = tasks.where((task) {
      // Assuming 'status' is the property for the status field in your TaskModel
      return task.status == 'Complete';
    }).toList();

    // Return the count of completed tasks
    return completedTasks.length;
  }
}
