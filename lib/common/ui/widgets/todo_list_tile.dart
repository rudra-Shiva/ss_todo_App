import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';

class ToDoListTile extends StatefulWidget {
  final String? titile;
  final String? taskCategory;
  final String? taskStatus;
  final String? dateTime;
  const ToDoListTile({
    super.key,
    required this.titile,
    this.taskCategory,
    this.taskStatus,
    this.dateTime
  });

  @override
  State<ToDoListTile> createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
            child: ListTile(
              title: Text(widget.titile!,
                style:AppStyle.textStyle14(color: AppColor.black, fontWeight: FontWeight.w500) ,
              ),
              subtitle: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: AppColor.blueColor1,
                          size: Dimen.dimen_16.sp,
                        ),
                        SizedBox(width: Dimen.dimen_6.w,),
                        Text(widget.dateTime!,
                          style: AppStyle.textStyle14(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimen.dimen_6.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Dimen.dimen_80.w,
                          height: Dimen.dimen_26.h,
                          decoration: BoxDecoration(
                            color: AppColor.taskCategory,
                              border: Border.all(
                                color: AppColor.taskCategoryBorder,
                              ),
                              borderRadius: BorderRadius.circular(Dimen.dimen_8) // use instead of BorderRadius.all(Radius.circular(20))
                          ),
                          child: Center(child: Text(widget.taskCategory!,
                            style: AppStyle.textStyle12(),
                          )),
                        ),
                        Container(
                          width: Dimen.dimen_80.w,
                          height: Dimen.dimen_26.h,
                          margin: EdgeInsets.only(
                            left: Dimen.dimen_8.w
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.taskStatus,
                              border: Border.all(
                                  color: AppColor.taskStatusBorder,
                              ),
                              borderRadius: BorderRadius.circular(Dimen.dimen_8) // use instead of BorderRadius.all(Radius.circular(20))
                          ),
                          child: Center(child: Text(widget.taskStatus!,
                            style: AppStyle.textStyle12(),
                          )),
                        )

                      ],
                    )

                  ],
                ),
              ),
            ),
    );
  }
}
