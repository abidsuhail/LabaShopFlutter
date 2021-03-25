import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/model/order_model.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

import 'base/view_model.dart';

class MyOrdersListFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static MyOrdersListFragmentVm _mInstance;
  static MyOrdersListFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new MyOrdersListFragmentVm();
    }
    return _mInstance;
  }

  Future<List<OrderModel>> getMyOrdersList(
      {@required ScreenCallback listener}) async {
    return productsRepo.getMyOrdersList(listener: listener);
  }

  Future<List<OrderDetails>> getOrderDetails(
      {@required ScreenCallback listener, @required int orderId}) async {
    return productsRepo.getOrderDetails(listener: listener, orderId: orderId);
  }

  Future<String> cancelOrder(
      {@required ScreenCallback listener, @required int orderId}) async {
    Map<String, String> params = Map<String, String>();
    params["id"] = orderId.toString();
    params["authtoken"] = AppSharedPrefs.getSyncAuthToken();
    return productsRepo.cancelOrder(listener: listener, params: params);
  }
}
