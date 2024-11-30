import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';

class SearchFilterWidget extends StatelessWidget {
  final VoidCallback? pending;
  final VoidCallback? onGoing;
  final VoidCallback? complete;
  final VoidCallback? reset;
  const SearchFilterWidget({super.key, this.pending, this.onGoing, this.complete, this.reset});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Dimen.dimen_28.h,
            margin: EdgeInsets.only(right: Dimen.dimen_6.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimen.dimen_8),
                border: Border.all(
                    color: AppColor.greyColor3, width: Dimen.dimen_1)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: Dimen.dimen_105),
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimen.dimen_15.w,
                  right: Dimen.dimen_12.w,
                ),
                child: Center(child: Text("Filter By",style: AppStyle.textStyle12(color: AppColor.black),)),
              ),
            ),
          ),

          InkWell(
            onTap:pending,
            child: Container(
              height: Dimen.dimen_28.h,
              margin: EdgeInsets.only(right: Dimen.dimen_6.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.dimen_8),
                  border: Border.all(
                      color: AppColor.greyColor3, width: Dimen.dimen_1)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: Dimen.dimen_105),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimen.dimen_15,
                    right: Dimen.dimen_12,
                  ),
                  child: Center(child: Text("Pending",style: AppStyle.textStyle12(color: AppColor.black),)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onGoing,
            child: Container(
              height: Dimen.dimen_28.h,
              margin: EdgeInsets.only(right: Dimen.dimen_6.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.dimen_8),
                  border: Border.all(
                      color: AppColor.greyColor3, width: Dimen.dimen_1)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: Dimen.dimen_105),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimen.dimen_15,
                    right: Dimen.dimen_12,
                  ),
                  child: Center(child: Text("Ongoing",style: AppStyle.textStyle12(color: AppColor.black),)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: complete,
            child: Container(
              height: Dimen.dimen_28.h,
              margin: EdgeInsets.only(right: Dimen.dimen_6.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.dimen_8),
                  border: Border.all(
                      color: AppColor.greyColor3, width: Dimen.dimen_1)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: Dimen.dimen_105),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimen.dimen_15,
                    right: Dimen.dimen_12,
                  ),
                  child: Center(child: Text("Completed",style: AppStyle.textStyle12(color: AppColor.black),)),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: reset,
            child: Container(
              height: Dimen.dimen_28.h,
              margin: EdgeInsets.only(right: Dimen.dimen_6.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.dimen_8),
                  border: Border.all(
                      color: AppColor.greyColor3, width: Dimen.dimen_1)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: Dimen.dimen_105),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimen.dimen_15,
                    right: Dimen.dimen_12,
                  ),
                  child: Center(child: Text("Filter Reset",style: AppStyle.textStyle12(color: AppColor.black),)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
