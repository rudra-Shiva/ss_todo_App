
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String taskName ="";
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      emit(SearchProgress());
      if(event is SearchTaskEvent){
        taskName = event.searchIdOrName;
        if(event.searchIdOrName.isEmpty){
          emit(SearchInitial());
        }else {
          emit(SearchFinal(taskName));
        }

      }
    });
  }
}
