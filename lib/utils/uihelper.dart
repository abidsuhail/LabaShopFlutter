import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';

class UIHelper
{
  static HtmlUnescape htmlUnscape;
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
    if(htmlUnscape==null) {
      htmlUnscape = new HtmlUnescape();
    }
    return htmlUnscape.convert(text);
  }
}