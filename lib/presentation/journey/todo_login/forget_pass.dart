import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/services/global_methods.dart';
import 'package:todo_app/common/ui/drawables/drawables.dart';
import 'package:todo_app/common/ui/res/dimen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isLoading = false;
  late TextEditingController _forgetPassTextController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _animationController.dispose();
    _forgetPassTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  void _forgetPasFCT() async {
    print('_forgetPassTextController.text ${_forgetPassTextController.text}');
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    final email = _forgetPassTextController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      GlobalMethod.showErrorDialog(
          error: "Please enter a valid email address", ctx: context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      GlobalMethod.showErrorDialog(
          error: "Password reset email sent to $email", ctx: context);
      Navigator.pushNamed(context, RouteList.loginRoute);
    } catch (e) {
      GlobalMethod.showErrorDialog(error: e.toString(), ctx: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: Dimen.dimen_16.w, top: Dimen.dimen_8.h),
              child: Image.asset(
                Drawables.todoLogo, // Adjust the path accordingly
                // fit: BoxFit.contain,
                // height: 200.0, // Set the initial height for the image
                width: Dimen.dimen_50.w,
                height: Dimen.dimen_50.h,
                fit: BoxFit.cover,
                alignment: FractionalOffset(_animation.value, 0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimen.dimen_16.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Forget password',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email address',
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _forgetPassTextController,
                    decoration: InputDecoration(
                      hintText: "Email...",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  MaterialButton(
                    minWidth: size.width.w,
                    height: Dimen.dimen_50.h,
                    onPressed: _forgetPasFCT,
                    color: Colors.pink.shade700,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: _isLoading
                          ? Center(
                              child: const CircularProgressIndicator(
                                // color: Colors.red,
                                strokeWidth: 3,
                              ),
                            ) // Show loading indicator
                          : Text(
                              'Reset now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
