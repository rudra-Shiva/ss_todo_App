import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';
import 'package:todo_app/domain/entity/task/task_model.dart';

class ToDoListCallbackTile extends StatefulWidget {
  final TaskModel? taskModel;
  final VoidCallback onPressed;
  final VoidCallback? onDeletePressed;
  const ToDoListCallbackTile({
    super.key,
    this.taskModel,
    required this.onPressed,
    this.onDeletePressed
  });

  @override
  State<ToDoListCallbackTile> createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListCallbackTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: widget.onPressed,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.taskModel?.taskName ?? "" ,
              style:AppStyle.textStyle14(color: AppColor.black, fontWeight: FontWeight.w500) ,
            ),
            IconButton(

                onPressed: widget.onDeletePressed,
                icon: Icon(Icons.delete_forever,size: Dimen.dimen_22.sp,)
            )
          ],
        ),

        subtitle: Column(
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
                Text(
                  "${widget.taskModel?.startDate.toString().substring(0, 11)}"
                      " ${widget.taskModel?.endDate.toString().substring(0, 10)}",
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
                  child: Center(child: Text(widget.taskModel?.category?? "",
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
                  child: Center(child: Text(widget.taskModel?.status ?? "",
                    style: AppStyle.textStyle12(),
                  )),
                )

              ],
            )

          ],
        ),
      ),
    );
  }
}
