import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIHelper
{
  static void showShortToast(String message)
  {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        fontSize: 13.0
    );
  }
}