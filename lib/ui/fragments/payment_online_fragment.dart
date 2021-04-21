import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:labashop_flutter_app/utils/payment.dart';

class PaymentOnlineFragment extends StatefulWidget {
  static const ID = 'PaymentOnlineFragment';

  @override
  _PaymentOnlineFragmentState createState() => _PaymentOnlineFragmentState();
}

class _PaymentOnlineFragmentState extends State<PaymentOnlineFragment> {
  FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  void initState() {
    flutterWebviewPlugin = new FlutterWebviewPlugin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.close();

    Payment.createRequest(context, flutterWebviewPlugin);
    return WillPopScope(
      onWillPop: () async {
        print('back pressed in payment frag');
        //flutterWebviewPlugin.close();
        if (await flutterWebviewPlugin.canGoBack()) {
          flutterWebviewPlugin.goBack();
          return false;
        } else {
          flutterWebviewPlugin.close();

          Navigator.pop(context);
          return true;
        }

        /*  flutterWebviewPlugin.canGoBack().then((value) {
          if (value) {
            flutterWebviewPlugin.close();
            return false;
          } else {
            Navigator.pop(context);
            return true;
          }
        }); */
      },
      child: Scaffold(
          appBar: AppBar(
        title: Text('Payment'),
      )),
    );
  }
}
