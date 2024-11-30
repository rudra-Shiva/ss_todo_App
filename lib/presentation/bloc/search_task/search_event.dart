part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}
class SearchInitialEvent extends SearchEvent{}
class SearchTaskEvent extends SearchEvent {
  final String searchIdOrName;
  SearchTaskEvent(this.searchIdOrName);
}
