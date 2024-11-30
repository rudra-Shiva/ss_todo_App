import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/ui/drawables/drawables.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/common/ui/theme/app_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // Add a delay to simulate the splash screen duration
    Timer(const Duration(seconds: 3), () {
      _animationController.forward();
      // Navigate to the main content or home page
      Timer(const Duration(seconds: 2), () {
        _initTimer();
      });
    });
  }

  _initTimer() {
    Timer(
      const Duration(seconds: 2),
      () => _checkLoginStatus(),
    );
  }

  _checkLoginStatus() async {
    Navigator.pushReplacementNamed(
      context,
      RouteList.loginRoute,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: AppColor.white,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Drawables.todoLogo, // Adjust the path accordingly
                  fit: BoxFit.contain,
                  // height: 200.0, // Set the initial height for the image
                  width: Dimen.dimen_230.w,
                  height: Dimen.dimen_80.h),
              
              
              Text("TODO APP",style: AppStyle.textStyle12(),)
            ],
          ),
        ),
      ),
    );
  }
}
