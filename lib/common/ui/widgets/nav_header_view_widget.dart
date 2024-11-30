
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/widgets/todo_text_button.dart';

import '../theme/app_style.dart';


class HeaderViewWidget extends StatelessWidget {
  final String? title;
  final String? suffixTitle;
  final VoidCallback? onSuffixPressed;
  final VoidCallback? onBackPress;
  final VoidCallback? onSuffixIconPressed;

  const HeaderViewWidget({
    Key? key,
    required this.title,
    this.onSuffixPressed,
    this.suffixTitle,
    this.onBackPress,
    this.onSuffixIconPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ScreenUtil().screenWidth,
        height: Dimen.dimen_60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  alignment: Alignment.center,
                  iconSize: Dimen.dimen_20,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    if(onBackPress==null) {

                      Navigator.pop(context);
                    }else{
                      onBackPress!();
                    }
                  },
                ),
                Text(title!,
                    style: AppStyle.textStyleMedium16(
                        color: AppColor.greyColor7,
                        fontWeight: FontWeight.w500)),

              ],
            ),
            (suffixTitle != null && onSuffixPressed != null)
                ? ToDoTextButton(onPressed: onSuffixPressed!, label: suffixTitle!)
                : IconButton(
              alignment: Alignment.center,
              iconSize: Dimen.dimen_20,
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ],
        ));
  }
}
