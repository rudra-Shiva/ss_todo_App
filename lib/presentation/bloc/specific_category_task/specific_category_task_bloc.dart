
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';
import 'package:todo_app/usecases/task/get_specific_category_task_usecase.dart';

part 'specific_category_task_event.dart';
part 'specific_category_task_state.dart';

class SpecificCategoryTaskBloc extends Bloc<SpecificCategoryTaskEvent, SpecificCategoryTaskState> {
  late GetSpecificCategoryTaskUseCase _specificCategoryTask;
  SpecificCategoryTaskBloc() : super(SpecificCategoryTaskInitial()) {
    _specificCategoryTask = getInstance<GetSpecificCategoryTaskUseCase>();
    on<SpecificCategoryTaskEvent>((event, emit) async{
     emit(SpecificCategoryTaskProgress());
     await Future.delayed(const Duration(milliseconds: 1000), () {
     });
     if(event is SpecificCategoryFinalTaskEvent){
       // emit(SpecificCategoryTaskInitial());
       var result = await _specificCategoryTask.call(event.taskCategory);
       result.fold(
               (l) => emit(SpecificCategoryTaskFailed(message: l.toString())),
               (r) => emit(SpecificCategoryTaskSuccess(r)),
       );
     }
    });
  }
}
