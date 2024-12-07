import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/common/navigation/route_list.dart';
import 'package:todo_app/common/services/global_methods.dart';
import 'package:todo_app/common/ui/drawables/drawables.dart';
import 'package:todo_app/common/ui/res/dimen.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';
import 'package:todo_app/di/get_it.dart';
import 'package:todo_app/domain/entity/user/user_entity.dart';
import 'package:todo_app/presentation/bloc/add_task/add_task_bloc.dart';
import 'package:todo_app/presentation/bloc/todo_register/todo_register_bloc.dart';
import 'package:todo_app/presentation/journey/util/flutter_toast.dart';

class TodoUserRegister extends StatefulWidget {
  const TodoUserRegister({super.key});

  @override
  State<TodoUserRegister> createState() => _TodoUserRegisterState();
}

class _TodoUserRegisterState extends State<TodoUserRegister> {
  final _registerFormKey = GlobalKey<FormState>();

  late TodoRegisterBloc _todoRegisterBloc;
  late TextEditingController _fullNameController =
      TextEditingController(text: '');
  late TextEditingController _emailTextController =
      TextEditingController(text: '');
  late TextEditingController _phoneNumberController =
      TextEditingController(text: '');
  late TextEditingController _passTextController =
      TextEditingController(text: '');

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _todoRegisterBloc = getInstance<TodoRegisterBloc>();
  }

  @override
  void dispose() {
    super.dispose();

    _emailTextController.dispose();
    _passTextController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passFocusNode.dispose();
  }

  void _submitFormOnSignUp() async {
    final isValid = _registerFormKey.currentState!.validate();
    if (isValid) {
      // if (imageFile == null) {
      //   GlobalMethod.showErrorDialog(
      //       error: 'Please pick an image', ctx: context);
      //   return;
      // }

      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailTextController.text.trim().toLowerCase(),
            password: _passTextController.text.trim());
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('userImages')
        //     .child(_uid + '.jpg');
        // await ref.putFile(imageFile!);
        // imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('registerUsers').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _emailTextController.text,
          // 'userImage': imageUrl,
          'phoneNumber': _phoneNumberController.text,
          // 'positionInCompany': _postitionCPTextController.text,
          'createdAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethod.showErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _todoRegisterBloc),
        // BlocProvider.value(value: _deleteTaskBloc)
      ],
      child: Scaffold(
          // color: AppColor.white,
          body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Drawables.todoLogo, // Adjust the path accordingly
              // fit: BoxFit.contain,
              // height: 200.0, // Set the initial height for the image
              width: Dimen.dimen_50.w,
              height: Dimen.dimen_50.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Register here...',
                    style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account',
                          style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        TextSpan(text: '    '),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                context, RouteList.loginRoute),

                          //Comment for reference
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SignUp(),
                          //   ),
                          // ),
                          text: 'Login',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue.shade300,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Expanded(
                    flex: 1,
                    // height: ScreenUtil().setHeight(10),
                    // color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(_emailFocusNode),
                                  keyboardType: TextInputType.name,
                                  controller: _fullNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter a Full Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: TextStyle(color: AppColor.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  focusNode: _emailFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(_phoneNumberFocusNode),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailTextController,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains("@")) {
                                      return "Please enter a valid Email adress";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: AppColor.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  focusNode: _phoneNumberFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(_passFocusNode),
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneNumberController,
                                  validator: (value) {
                                    // Regular expression to check if the input is a 10-digit number not starting with 0
                                    final RegExp mobileRegExp =
                                        RegExp(r'^[1-9][0-9]{9}$');

                                    if (value == null || value.isEmpty) {
                                      return "Please enter your mobile number";
                                    } else if (!mobileRegExp.hasMatch(value)) {
                                      return "Please enter a valid 10-digit mobile number";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    hintText: 'Phone No.',
                                    hintStyle: TextStyle(color: AppColor.black),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimen.dimen_20.h,
                                ),
                                //Password

                                TextFormField(
                                  focusNode: _passFocusNode,
                                  obscureText: _obscureText,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _passTextController,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 5) {
                                      return "Please enter a valid password";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(color: AppColor.black),
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
                                    hintText: 'Password',
                                    hintStyle:
                                        const TextStyle(color: AppColor.black),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimen.dimen_15.h,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 250.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BlocConsumer<TodoRegisterBloc,
                                    TodoRegisterState>(
                                  listener: (context, state) {
                                    if (state is TodoRegisterProgress) {
                                      SizedBox(
                                        height: size.height.h,
                                        width: size.width.w,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else if (state is TodoRegisterSuccess) {
                                      Fluttertoast.showToast(
                                        msg: "Registration successful!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0.sw,
                                      );
                                      // GlobalMethod.showErrorDialog(
                                      //     title: "Success: ",
                                      //     error: "User added Successfully",
                                      //     ctx: context);

                                      Navigator.pushNamed(context, RouteList.loginRoute);
                                      dispose();
                                    } else if (state is TodoRegisterFailed) {
                                      GlobalMethod.showErrorDialog(
                                          error: state.message!, ctx: context);
                                    }
                                  },
                                  builder: (context, state) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Dimen.dimen_10.h),
                                      child: MaterialButton(
                                        onPressed: () {
                                          _todoRegisterBloc.add(
                                              UserRegisterEvent(UserEntity(
                                                  name:
                                                      _fullNameController.text,
                                                  email:
                                                      _emailTextController.text,
                                                  password:
                                                      _passTextController.text,
                                                  timeStamp:
                                                      DateTime.timestamp()
                                                          .toString())));
                                        },
                                        color: AppColor.greenColor4,
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimen.dimen_14.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Register',
                                                style: TextStyle(
                                                    color: AppColor.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimen.dimen_20.h),
                                              ),
                                              SizedBox(
                                                width: Dimen.dimen_8.w,
                                              ),
                                              const Icon(
                                                Icons.login,
                                                color: AppColor.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
