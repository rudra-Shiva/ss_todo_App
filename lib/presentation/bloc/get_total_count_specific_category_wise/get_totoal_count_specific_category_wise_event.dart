part of 'get_totoal_count_specific_category_wise_bloc.dart';

@immutable
abstract class GetTotalCountSpecificCategoryWiseEvent {}

class GetTotalCountInitialEvent extends GetTotalCountSpecificCategoryWiseEvent{

}

class GetTotalCountFinalEvent extends GetTotalCountSpecificCategoryWiseEvent{
 final String category;
 GetTotalCountFinalEvent(this.category);
}
