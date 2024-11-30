part of 'specific_category_task_bloc.dart';

@immutable
abstract class SpecificCategoryTaskEvent {}

class SpecificCategoryInitialTaskEvent extends SpecificCategoryTaskEvent{

}

class SpecificCategoryFinalTaskEvent extends SpecificCategoryTaskEvent{
  final String taskCategory;
  SpecificCategoryFinalTaskEvent(this.taskCategory);
}
