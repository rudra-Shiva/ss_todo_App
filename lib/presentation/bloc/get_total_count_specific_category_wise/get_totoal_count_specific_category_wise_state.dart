part of 'get_totoal_count_specific_category_wise_bloc.dart';

@immutable
abstract class GetTotalCountSpecificCategoryWiseState {
  const GetTotalCountSpecificCategoryWiseState();
}

class GetTotalCountSpecificCategoryWiseInitial extends GetTotalCountSpecificCategoryWiseState {}

class GetTotalCountProgress extends GetTotalCountSpecificCategoryWiseState {

}

class GetTotalCountSuccess extends GetTotalCountSpecificCategoryWiseState {
  final int totalCategoryWiseTask;
  final int totalCompletedTask;
  const GetTotalCountSuccess(this.totalCategoryWiseTask, this.totalCompletedTask);

}

class GetTotalCountFailed extends GetTotalCountSpecificCategoryWiseState {
 final String? message;
 const GetTotalCountFailed({this.message});
}
