import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:provider/provider.dart';

import 'base/view_model.dart';

class ProductDetailsFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static ProductDetailsFragmentVm _mInstance;
  CartModel cartModel;
  String cartCount = '0';
  List<Product> products = [];
  static ProductDetailsFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new ProductDetailsFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Product>> getProductsByCat(
      String catId, String subCatId, String pageSize, String pageNo,
      {@required ScreenCallback listener}) async {
    return await productsRepo.getProductsByCategory(
        catId: catId,
        subCatId: subCatId,
        pageSize: pageSize,
        pageNo: pageNo,
        listener: listener);
  }

  Future<String> addToCart(Product product, String single,
      {@required ScreenCallback listener, BuildContext context}) async {
    String size = product.price[0].size;
    cartModel = await AppSharedPrefs.getCartModel();
    double p =
        product.price.isNotEmpty ? double.parse(product.price[0].cost) : 0.0;
    double c = product.qty * p;
    product.cost = c.round().toString();
    product.size = size;
    String sessionId = AppSharedPrefs.getSyncAuthToken();
    if (sessionId == null || sessionId == '') {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      sessionId = androidInfo.androidId;
    }

    String sid = '';
    String pid = '';
    String qtyA = '';
    String cost = '';
    String sizeStr = '';
    List<String> pidArr = cartModel.getPidArray();
    List<String> qtyArr = cartModel.getQtyArray();
    List<String> costArr = cartModel.getCostArray();
    List<String> sizeArr = cartModel.getSizeArray();
    int itemCount = 0;
    for (int j = 0; j < pidArr.length; j++) {
      if (!_isCartProductIdExistInList(pidArr[j], product)) {
        sid = sid + sessionId + ',';
        pid = pid + pidArr[j] + ',';
        qtyA = qtyA + qtyArr[j] + ',';
        cost = cost + costArr[j] + ',';
        sizeStr = sizeStr + sizeArr[j] + ',';
        itemCount++; //cart count
      }
    }
    if (product.qty > 0) {
      sid = sid + sessionId + ",";
      pid = pid + product.productId.toString() + ",";
      qtyA = qtyA + product.qty.toString() + ",";
      cost = cost + product.cost + ",";
      sizeStr = sizeStr + product.size + ",";
      itemCount++;
    }

    setCartCount(itemCount.toString(), context);
    print('pid id $pid');
    if (sid.length > 0) sid = sid.substring(0, sid.length - 1);
    if (pid.length > 0) pid = pid.substring(0, pid.length - 1);
    if (qtyA.length > 0) qtyA = qtyA.substring(0, qtyA.length - 1);
    if (cost.length > 0) cost = cost.substring(0, cost.length - 1);
    if (sizeStr.length > 0) sizeStr = sizeStr.substring(0, sizeStr.length - 1);
    cartModel.pid = (pid);
    cartModel.qty = (qtyA);
    cartModel.sid = (sid);
    cartModel.cost = (cost);
    cartModel.size = (sizeStr);
    //AppSharedPref.getInstance().putPref(AppSharedPref.CART_JSON, new Gson().toJson(cartModel));
    AppSharedPrefs.saveCartJSON(jsonEncode(cartModel));
    if (pid == '') sid = sessionId;
    return productsRepo.addToCart(
        sid, pid, qtyA, cost, sizeStr, false.toString(),
        listener: listener);
  }

  bool _isCartProductIdExistInList(String productId, Product product) {
    bool flag = false;
    if (productId == '') {
      flag = true;
    } else {
      if (product.productId.toString() == productId) {
        flag = true;
      }
    }
    return flag;
  }

  setCartCount(String count, BuildContext context) {
    Provider.of<HomeScreenVm>(context, listen: false).setCartCount(cartCount);
  }
}
