import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';
import 'package:todo_app/common/ui/widgets/search_bar_widget.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:todo_app/presentation/bloc/search_task/search_bloc.dart';
import 'package:todo_app/presentation/bloc/task_list_by_status/task_list_by_status_bloc.dart';
import 'package:todo_app/presentation/journey/search_task_by_status/search_filter_widget.dart';
import 'package:todo_app/presentation/journey/search_task_by_status/task_list_widget.dart';

class SearchTaskView extends StatefulWidget {
  const SearchTaskView({super.key});

  @override
  State<SearchTaskView> createState() => _SearchTaskViewState();
}

class _SearchTaskViewState extends State<SearchTaskView> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController searchController;
  late GetAllTasksBloc _getAllTasksBloc;
  late SearchBloc _searchBloc;
  late TaskListByStatusBloc _listByStatusBloc;
  var loanApplicationList = [];
  String? searchValue = "";

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _getAllTasksBloc = getInstance<GetAllTasksBloc>();
    _listByStatusBloc = getInstance<TaskListByStatusBloc>();
    if (!_getAllTasksBloc.isClosed) {
      _getAllTasksBloc.add(GetAllTasksLoadingEvent());
    }
    _listByStatusBloc.add(TaskListByStatusInitialEvent());
    _searchBloc = getInstance<SearchBloc>();
    if (!_searchBloc.isClosed) {
      _searchBloc.add(SearchInitialEvent());
    }
  }

  Future<void> _refreshAllTask() async {
    if (!_getAllTasksBloc.isClosed) {
      _getAllTasksBloc.add(GetAllTasksLoadingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _getAllTasksBloc,
        ),
        BlocProvider.value(
          value: _searchBloc,
        ),
        BlocProvider.value(
          value: _listByStatusBloc),
      ],
      child: SingleChildScrollView(
        child: Column(
          children: [
             SearchFilterWidget(
              pending: (){
                _listByStatusBloc.add(TaskListByStatusFinalEvent("Pending"));
              },
              onGoing: (){
                _listByStatusBloc.add(TaskListByStatusFinalEvent("Ongoing"));
              },
              complete: (){
                _listByStatusBloc.add(TaskListByStatusFinalEvent("Complete"));
              },
               reset: (){
                 _listByStatusBloc.add(TaskListByStatusInitialEvent());
                 _getAllTasksBloc.add(GetAllTasksLoadingEvent());
                 if (!_getAllTasksBloc.isClosed) {
                   _getAllTasksBloc.add(GetAllTasksLoadingEvent());
                 }

               },
            ),
            Container(
              color: AppColor.white,
              padding: EdgeInsets.only(top: Dimen.dimen_10.h),
              child: SearchBarWidget(
                onSearched: (val) {
                  if (val.trim().isNotEmpty) {}
                  return null;
                },
                editingController: searchController,
                placeHolder: "Search by Name or Start date",
                textInputType: TextInputType.none,
                obscureText: false,
                enableSuggestions: true,
                autocorrect: true,
                textInputAction: TextInputAction.search,
                isEditable: true,
                onChange: (val) {
                  if (val.isEmpty) {
                    setState(() {
                      searchValue = "";
                    });
                    _searchBloc.add(SearchInitialEvent());
                    _refreshAllTask();
                    return;
                  }
                  _searchBloc.add(SearchTaskEvent(val));
                  if (_searchBloc.isClosed) {
                    _searchBloc.add(SearchTaskEvent(val));
                  }
                  return null;
                },
              ),
            ),
            BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
              builder: (context, state) {
                if (state is GetAllTaskLoading) {
                  return Align(
                      alignment: Alignment.center,
                      widthFactor: Dimen.dimen_10.w,
                      heightFactor: Dimen.dimen_16.h,
                      child: const Center(child: CircularProgressIndicator()));
                }
                if (state is GetAllTaskFailure) {
                  return Center(
                      child: Card(
                          elevation: Dimen.dimen_6,
                          child: Center(
                              heightFactor: 10,
                              child: Text(state.message!.contains(
                                      "AppError(AppErrorType.database)")
                                  ? "No Data Found!!"
                                  : state.message!))));
                }
                if (state is GetAllTaskSuccess) {
                  if(loanApplicationList.isEmpty){
                    loanApplicationList = state.taskDataModel;
                  }
                    else{
                    loanApplicationList.clear();
                    if(loanApplicationList.length == 0){
                      loanApplicationList = state.taskDataModel;
                    }

                  }
                  return BlocBuilder<TaskListByStatusBloc, TaskListByStatusState>(
                  builder: (context, state) {
                    if(state is TaskListByStatusProgress){
                        return Align(
                        alignment: Alignment.center,
                        widthFactor: Dimen.dimen_10.w,
                        heightFactor: Dimen.dimen_16.h,
                        child: const Center(child: CircularProgressIndicator()));

                  }
                    if(state is TaskListByStatusFailed){
                      return Center(
                          child: Card(
                              elevation: Dimen.dimen_6,
                              child: Center(
                                  heightFactor: 10,
                                  child: Text(state.message!.contains(
                                      "AppError(AppErrorType.database)")
                                      ? "No Data Found"
                                      : state.message!))));
                    }
                    if(state is TaskListByStatusSuccess){
                      loanApplicationList = state.listByStatus;
                    }
                  return Container(
                    color: AppColor.greyColor12,
                    height: ScreenUtil.defaultSize.height.h - Dimen.dimen_120.h,
                    child: CustomScrollView(
                        controller: _scrollController,
                        clipBehavior: Clip.hardEdge,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        slivers: [
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return BlocBuilder<SearchBloc, SearchState>(
                                builder: (context, state) {

                                  if (state is SearchFinal) {
                                    searchValue = searchController.text;
                                    // searchValue = state.searchTask;
                                    if (searchValue!.isEmpty) {
                                      _searchBloc.add(SearchInitialEvent());
                                      _refreshAllTask();
                                    }
                                    // widget.searchCubit
                                    //     .onSearchChangeState(searchValue);
                                    //  state.searchStateWrapper.searchValue;
                                  }
                                  return TaskListWidget(
                                    taskModel:
                                        loanApplicationList.elementAt(index),
                                    // searchByIdOrName: searchController.text,
                                    searchByIdOrName: searchController.value
                                                .toString()
                                                .length !=
                                            0
                                        ? searchValue
                                        : null,
                                    refreshList: _refreshAllTask,
                                  );
                                },
                              );
                            },
                            childCount: loanApplicationList.length,
                            addAutomaticKeepAlives: true,
                          )),
                        ]),
                  );
  },
);
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
