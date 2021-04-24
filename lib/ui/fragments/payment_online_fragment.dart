import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:labashop_flutter_app/utils/payment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentOnlineFragment extends StatefulWidget {
  static const ID = 'PaymentOnlineFragment';

  @override
  _PaymentOnlineFragmentState createState() => _PaymentOnlineFragmentState();
}

class _PaymentOnlineFragmentState extends State<PaymentOnlineFragment> {
  FlutterWebviewPlugin flutterWebviewPlugin;
  String selectedUrl = '';
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // flutterWebviewPlugin = new FlutterWebviewPlugin();
    createRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: wb == null
          ? Container(child: Center(child: CircularProgressIndicator()))
          : wb,
    );
  }

  WebView wb;
  Future createRequest() async {
    // ignore: unused_local_variable

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
      setState(() {
        selectedUrl =
            jsonDecode(resp.body)["payment_request"]['longurl'].toString() +
                "?embed=form";
        wb = WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (val) {},
          onPageFinished: (finish) {},
        );
      });
    } else {
      UIHelper.showShortToast(json.decode(resp.body)['message'].toString());
    }
  }
}
