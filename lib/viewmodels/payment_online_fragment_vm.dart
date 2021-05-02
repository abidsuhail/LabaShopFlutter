import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

import 'base/view_model.dart';

class PaymentOnlineFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
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
