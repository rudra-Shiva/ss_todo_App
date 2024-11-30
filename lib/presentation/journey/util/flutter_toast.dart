
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage{


  void showToast(String? message){

    Fluttertoast.showToast(
        msg:  message??("Something went wrong"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        fontSize: 16.0
    );
  }
}