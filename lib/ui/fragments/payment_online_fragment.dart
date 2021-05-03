import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/model/payment_request_model.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/payment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/payment_online_fragment_vm.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import 'order_details_fragment.dart';

class PaymentOnlineFragment extends StatefulWidget {
  static const ID = 'PaymentOnlineFragment';

  @override
  _PaymentOnlineFragmentState createState() => _PaymentOnlineFragmentState();
}

class _PaymentOnlineFragmentState extends State<PaymentOnlineFragment>
    implements ScreenCallback {
  FlutterWebviewPlugin flutterWebviewPlugin;
  String selectedUrl = '';
  WebView wb;
  bool isPageLoadFinished = false;
  PaymentOnlineFragmentVm vm;
  @override
  void initState() {
    vm = PaymentOnlineFragmentVm.getInstance();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // flutterWebviewPlugin = new FlutterWebviewPlugin();
    createRequest();
    super.initState();
  }

  int progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: wb == null
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Container(
              child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress != 100 ? null : progress.toDouble(),
                ),
                Expanded(child: wb),
              ],
            )),
    );
  }

  Future createRequest() async {
    // ignore: unused_local_variable

    Map<String, String> body = {
      "amount": await AppSharedPrefs.getTotalPayableAmt(),
      "purpose": "LabaShopping",
      "buyer_name": 'Abid',
      "email": 'abid1294005@gmail.com',
      "phone": '+917007469297',
      "allow_repeated_payments": "true",
      "send_email": "true",
      "send_sms": "true",
      "redirect_url": "http://www.google.com/",
      "webhook": "http://www.google.com/"
    };
    var resp = await http.post(
        Uri.encodeFull("https://test.instamojo.com/api/1.1/payment-requests/"),
        headers: getPaymentHeader(),
        body: body);

    if (json.decode(resp.body)['success'] == true) {
      PaymentRequestModel request = PaymentRequestModel.fromJson(
          jsonDecode(resp.body)["payment_request"]);

      print('transaction id ${request.id}');
      setState(() {
        selectedUrl =
            jsonDecode(resp.body)["payment_request"]['longurl'].toString() +
                "?embed=form";

        wb = WebView(
          initialUrl: selectedUrl,
          onPageStarted: (url) {
            print('onPageStarted : $url');
            if (url.contains('https://www.google.com/')) {
              Uri uri = Uri.parse(url);
              String paymentRequestId = uri.queryParameters['payment_id'];
              String transactionId = request.id;
              _checkPaymentStatus(paymentRequestId, transactionId);
            }
          },
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (val) {},
          onPageFinished: (finish) {
            setState(() {
              print('isPageLoadFinished $isPageLoadFinished');
              progress = 100;
              isPageLoadFinished = true;
            });
          },
        );
        setState(() {
          isPageLoadFinished = false;
        });
      });
    } else {
      UIHelper.showShortToast(json.decode(resp.body)['message'].toString());
    }
  }

  Map<String, String> getPaymentHeader() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Api-Key": "test_b5142df51424c67e02c92f6c366",
      "X-Auth-Token": 'test_21194bb80fc294b1127c174b82a',
      "Access-Control-Allow-Headers":
          "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With",
      "Access-Control-Allow-Methods": "DELETE, POST, GET, OPTIONS",
      "Access-Control-Allow-Origin": "*"
    };
  }

  void placeOrder(
      String paymentRequestId, String transactionId, String status) {
    AppSharedPrefs.getSelectedAddress().then((Address address) {
      AppSharedPrefs.getTotalPayableAmt().then((String payableAmt) {
        vm.getOrderId(payableAmt, this).then((orderId) async {
          if (orderId != null) {
            vm
                .createOrder(
                    listener: this,
                    addressId: address.addressId.toString(),
                    payableAmount: payableAmt,
                    paymentMode: 'Instamojo',
                    sessionId: await AppSharedPrefs.getAuthToken(),
                    orderNumber: orderId,
                    transactionID: transactionId, //payment req id
                    paymentID: paymentRequestId, //payment_id
                    paymentStatus: status)
                .then((List<OrderDetails> orderDetailsList) {
              UIHelper.showShortToast('Order Placed');
              Provider.of<FragmentNotifier>(context, listen: false).setFargment(
                  OrderDetailsFragment.ID,
                  object: orderDetailsList);
              Navigator.pop(context);
            });
          } else {
            UIHelper.showShortToast('order id is null');
          }
        });
      });
    });
  }

  void _checkPaymentStatus(
      String paymentRequestId, String transactionId) async {
    var res = await http.get(
      'https://test.instamojo.com/api/1.1/payments/$paymentRequestId',
      headers: getPaymentHeader(),
    );
    var realResponse = jsonDecode(res.body);
    print(res.body);
    if (realResponse['success'] == true) {
      if (realResponse["payment"]['status'] == 'Credit') {
        //payment is successful.
        UIHelper.showShortToast('PAYMENT SUCCESS');
        String status = realResponse["payment"]['status'];
        placeOrder(paymentRequestId, transactionId, status);
      } else {
        //payment failed or pending.
      }
    } else {
      print("PAYMENT STATUS FAILED");
      UIHelper.showShortToast('PAYMENT FAILED!!!');
    }
  }

  @override
  void hideProgress() {
    if (isDialogShowing) {
      Navigator.pop(context);
      isDialogShowing = false;
    }
  }

  @override
  void onError(String message) {
    if (isDialogShowing) {
      Navigator.pop(context);
      isDialogShowing = false;
    }
    UIHelper.showShortToast(message);
  }

  @override
  void showProgress() {
    if (!isDialogShowing) {
      showLoaderDialog(context);
    }
  }

  bool isDialogShowing = false;
  showLoaderDialog(BuildContext context) {
    isDialogShowing = true;
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Placing Order,please wait..")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
