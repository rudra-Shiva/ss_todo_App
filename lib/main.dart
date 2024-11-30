import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/TodoApp.dart';
import 'package:todo_app/di/get_it.dart' as get_it;
import 'package:permission_handler/permission_handler.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  unawaited(get_it.init());
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ScreenUtil.ensureScreenSize();
  var storageStatus = await Permission.storage.isGranted;
  if (!storageStatus) {
    Permission.storage.request();
  }
   await checkFirebaseConnection();


  runApp(const ToDoApp());
}


Future<void> checkFirebaseConnection() async {
  try {
    await Firebase.initializeApp();
    print('*******************Firebase initialized successfully.*********************');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}