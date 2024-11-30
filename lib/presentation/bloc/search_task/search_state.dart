part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}
class SearchProgress extends SearchState {}
class SearchFinal extends SearchState {
  final String? searchTask;
  const SearchFinal(this.searchTask);
}
class SearchFailed extends SearchState {
  final String? message;
  const SearchFailed(this.message);
}
