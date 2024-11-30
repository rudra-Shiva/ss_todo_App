
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';
import 'package:todo_app/common/ui/widgets/dialog_box/dialog_box.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';


class TaskListWidget extends StatefulWidget {
  final TaskModel taskModel;
  final String? searchByIdOrName;
  final Future Function()? refreshList;

  const TaskListWidget(
      {Key? key,
        required this.taskModel,
        this.searchByIdOrName,
        this.refreshList
      })
      : super(key: key);

  @override
  State<TaskListWidget> createState() =>
      _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.taskModel.taskName!.contains("${widget.searchByIdOrName}") ||
      widget.taskModel.id.toString().startsWith("${widget.searchByIdOrName}")) {
      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width
              .w,
          padding: const EdgeInsets.only(
              left: Dimen.dimen_12, right: Dimen.dimen_12, top: Dimen.dimen_16),
          decoration: const BoxDecoration(color: AppColor.greyColor12),
          child: InkWell(
            onTap: () async {
              await DialogBox.onAddTaskPressed(context,
                  existingTask: widget.taskModel,
                  updateStateCallback: widget.refreshList);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Dimen.dimen_16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskModel.taskName ?? "",
                      textAlign: TextAlign.start,
                      style: AppStyle.textStyle12(
                          color: AppColor.greyColor5,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "Task ID: ",
                          style: AppStyle.textStyle12(
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackBlueColor1),
                        ),
                        SizedBox(
                          width: Dimen.dimen_2.w,
                        ),
                        Text(
                          widget.taskModel.id.toString(),
                          style: AppStyle.textStyle12(
                              fontWeight: FontWeight.w600,
                              color: AppColor.greyColor8),
                        ),
                      ],
                    ),
                    Divider(
                      height: Dimen.dimen_10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CREATION DATE",
                          style: AppStyle.textStyle10(
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackBlueColor1),
                        ),
                        SizedBox(
                          width: Dimen.dimen_90.w,
                          child: Text(
                            "completion Date".toUpperCase(),
                            style: AppStyle.textStyle10(
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackBlueColor1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.taskModel.startDate
                              .split(' ')
                              .first,
                          style: AppStyle.textStyle12(
                              fontWeight: FontWeight.w500,
                              color: AppColor.greyColor9),
                        ),
                        SizedBox(
                          width: Dimen.dimen_90.w,
                          child: Text(
                            widget.taskModel.endDate
                                .split(' ')
                                .first,
                            style: AppStyle.textStyle12(
                                fontWeight: FontWeight.w500,
                                color: AppColor.greyColor9),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CREATION TIME",
                          style: AppStyle.textStyle10(
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackBlueColor1),
                        ),
                        SizedBox(
                          width: Dimen.dimen_90.w,
                          child: Text(
                            "completion Time".toUpperCase(),
                            style: AppStyle.textStyle10(
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackBlueColor1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.taskModel.startTime.toString().substring(10, 15),
                          style: AppStyle.textStyle12(
                              fontWeight: FontWeight.w500,
                              color: AppColor.greyColor9),
                        ),
                          SizedBox(
                            width: Dimen.dimen_90.w,
                            child: Text(
                              widget.taskModel.endTime.toString().substring(10, 15),
                              style: AppStyle.textStyle12(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.greyColor9),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: Dimen.dimen_8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Status",
                          style: AppStyle.textStyle10(
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackBlueColor1),
                        ),
                        SizedBox(
                          width: Dimen.dimen_90.w,
                          child: Text(
                            "Task Category",
                            style: AppStyle.textStyle10(
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackBlueColor1),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: Dimen.dimen_12.h,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.taskModel.status ?? "",
                          style: AppStyle.textStyle12(
                              fontWeight: FontWeight.w500,
                              color: widget.taskModel.status
                              !.contains('Pending')
                                  ? AppColor.yellowColor4
                                  : widget.taskModel.status!
                                  .contains('Rejected')
                                  ? AppColor.csRedThemeColor2
                                  : AppColor.greenColor4),
                        ),
                        SizedBox(
                          width: Dimen.dimen_90.w,
                          child: Text(
                            widget.taskModel.category ?? "",
                            style: AppStyle.textStyle12(
                                fontWeight: FontWeight.w500,
                                color: AppColor.greyColor9),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }else{
      return const SizedBox();
    }
  }
}