import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';

class Payment {
  static const String kAndroidUserAgent =
      "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36";

  static Future createRequest(
      BuildContext context, FlutterWebviewPlugin flutterWebviewPlugin) async {
    // ignore: unused_local_variable
    Rect fullScreenRect = new Rect.fromLTRB(0.0, 100.0,
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    Map<String, String> body = {
      "amount": "100",
      "purpose": "Advertising",
      "buyer_name": 'abc',
      "email": 'abid1294005@gmail.com',
      "phone": '+917007469297',
      "allow_repeated_payments": "true",
      "send_email": "false",
      "send_sms": "false",
      "redirect_url": "http://www.google.com/",
      "webhook": "http://www.google.com/"
    };
    var resp = await http.post(
        Uri.encodeFull("https://test.instamojo.com/api/1.1/payment-requests/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "test_b5142df51424c67e02c92f6c366",
          "X-Auth-Token": 'test_21194bb80fc294b1127c174b82a',
          "Access-Control-Allow-Headers":
              "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With",
          "Access-Control-Allow-Methods": "DELETE, POST, GET, OPTIONS",
          "Access-Control-Allow-Origin": "*"
        },
        body: body);
    if (json.decode(resp.body)['success'] == true) {
      String selectedUrl =
          jsonDecode(resp.body)["payment_request"]['longurl'].toString() +
              "?embed=form";
      flutterWebviewPlugin.close();

      flutterWebviewPlugin.launch(selectedUrl, rect: fullScreenRect);
    } else {
      UIHelper.showShortToast(json.decode(resp.body)['message'].toString());
    }
  }
}
