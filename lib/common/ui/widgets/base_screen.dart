
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/widgets/nav_header_view_widget.dart';
import 'package:todo_app/common/ui/widgets/sidebar_drawer/sidebar_drawer.dart';


class BaseScreen extends StatelessWidget {
  final String title;
  final Widget widget;
  final EdgeInsetsGeometry? padding;
  final String? suffixTitle;
  final VoidCallback? onSuffixPressed;
  final VoidCallback? onBackPress;

  const BaseScreen(
      {Key? key,
        required this.title,
        required this.widget,
        this.padding,
        this.suffixTitle,
        this.onSuffixPressed,
        this.onBackPress
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawerEnableOpenDragGesture: true,
      drawer: const SidebarDrawer(),
      body: Column(
        children: [
          HeaderViewWidget(
            title: title,
            suffixTitle: suffixTitle,
            onSuffixPressed: onSuffixPressed,
            onBackPress: onBackPress,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(horizontal: Dimen.dimen_16.w),
              child: widget,
            ),
          )
        ],
      ),
    );
  }
}
