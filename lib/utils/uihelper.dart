import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';

class UIHelper
{
  static HtmlUnescape _htmlUnscape;
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
  static String getHtmlUnscapeString(String text)
  {
    if(_htmlUnscape==null) {
      _htmlUnscape = new HtmlUnescape();
    }
    return _htmlUnscape.convert(text);
  }
}