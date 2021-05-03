import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/model/payment_request_model.dart';
import 'package:labashop_flutter_app/repositories/instamojo_payment_repo.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

import 'base/view_model.dart';

class PaymentOnlineFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  InstamojoPaymentRepo instamojoPaymentRepo =
      InstamojoPaymentRepo.getInstance();
  static PaymentOnlineFragmentVm _mInstance;
  static PaymentOnlineFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new PaymentOnlineFragmentVm();
    }
    return _mInstance;
  }

  Future<String> getOrderId(String amount, ScreenCallback listener) async {
    return await productsRepo.getOrderId(amount,
        listener: listener, params: null);
  }

  Future<PaymentRequestModel> initInstamojoPaymentReq(
      {@required ScreenCallback listener}) async {
    Map<String, String> params = {
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
    return instamojoPaymentRepo.initInstamojoPaymentRequest(
        listener: listener, params: params);
  }

  Future<List<OrderDetails>> createOrder(
      {@required ScreenCallback listener,
      @required String addressId,
      @required String payableAmount,
      @required String paymentMode,
      @required String sessionId,
      @required String orderNumber,
      @required String transactionID,
      @required String paymentID,
      @required String paymentStatus}) async {
    Map<String, String> params = new Map<String, String>();
    String authToken = AppSharedPrefs.getSyncAuthToken();
    String sessionId;
    if (authToken == null || authToken == '') {
      sessionId = await AppSharedPrefs.getSessionId();
    } else {
      sessionId = authToken;
    }
    params["authtoken"] = sessionId;
    params["addressId"] = addressId;
    params["payableAmount"] = payableAmount;
    params["paymentMode"] = paymentMode;
    params["sessionId"] = sessionId;
    params["orderNumber"] = orderNumber;
    params["transactionID"] = transactionID;
    params["paymentID"] = paymentID;
    params["paymentStatus"] = paymentStatus;
    return await productsRepo.createOrder(listener: listener, params: params);
  }
}
