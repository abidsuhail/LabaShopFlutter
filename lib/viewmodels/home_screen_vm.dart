import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/banner.dart' as AppBanners;
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

import 'base/view_model.dart';

class HomeScreenVm extends ChangeNotifier with ViewModel {
  CartModel cartModel;

  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static HomeScreenVm _mInstance;
  String cartCount = '0';
  List<Product> products = [];
  static HomeScreenVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new HomeScreenVm();
    }
    return _mInstance;
  }

  Future<List<Product>> getProductsOnHome(
      {@required ScreenCallback listener,
      @required pageNo,
      @required int pageSize}) async {
    listener.showProgress();
    ResponseStatus responseStatus = await productsRepo.getProductsOnHome(
        pageNo: pageNo, pageSize: pageSize);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<Product> products =
            responseParser.getProductList(responseStatus.getData()).products;
        CartModel cartModel = responseParser.getCart(responseStatus.getData());
        AppSharedPrefs.saveCartJSON(jsonEncode(cartModel));
        return products;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
        return null;
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
      return null;
    }
  }

  Future<List<Category>> getCategories(
      {@required ScreenCallback listener}) async {
    listener.showProgress();
    ResponseStatus responseStatus = await productsRepo.getCategories();
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<Category> product =
            responseParser.getCategoryList(responseStatus.getData()).categories;
        return product;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }

  Future<List<AppBanners.Banner>> getBanners(
      {@required ScreenCallback listener}) async {
    listener.showProgress();
    ResponseStatus responseStatus = await productsRepo.getBanners();
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<AppBanners.Banner> product =
            responseParser.getBannersList(responseStatus.getData()).banners;
        return product;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }

  Future<String> addToCart(Product product, int qty, String single,
      Price dropDownValue, List<Product> products, int pos,
      {@required ScreenCallback listener}) async {
    String size =
        product.price.length > 1 ? dropDownValue.size : product.price[0].size;
    products[pos].qty = qty;
    products[pos].size = size;
    this.products = products;
    cartModel = await AppSharedPrefs.getCartModel();
    double p =
        product.price.isNotEmpty ? double.parse(product.price[0].cost) : 0.0;
    double c = qty * p;
    product.qty = qty;
    product.cost = c.toString();

    product.qty = qty;
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
    print('----------------> $pidArr $qtyArr $costArr $sizeArr');
    int itemCount = 0;
    for (int j = 0; j < pidArr.length; j++) {
      print(
          '_isCartProductIdExistInList(pidArr[j]) ${_isCartProductIdExistInList(pidArr[j])}');
      if (!_isCartProductIdExistInList(pidArr[j])) {
        sid = sid + sessionId + ',';
        pid = pid + pidArr[j] + ',';
        qtyA = qtyA + qtyArr[j] + ',';
        cost = cost + costArr[j] + ',';
        sizeStr = sizeStr + sizeArr[j] + ',';
        itemCount++; //cart count
      }
    }
    for (int i = 0; i < products.length; i++) {
      Product p = products[i];
      if (p != null) if (p.qty > 0) {
        try {
          sid = sid + sessionId + ',';
          pid = pid + p.productId.toString() + ',';
          qtyA = qtyA + p.qty.toString() + ',';
          sizeStr = sizeStr + p.size + ',';
          cost = cost +
              double.parse(p.cost.replaceAll('SAR', '').replaceAll(' ', ''))
                  .toString() +
              ',';
          itemCount++; //cart count
        } catch (e) {
          print('exception caught : $e');
        }
      }
    }
    setCartCount(itemCount.toString());
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

  bool _isCartProductIdExistInList(String productId) {
    bool flag = false;
    if (productId == '') {
      flag = true;
    } else {
      for (int i = 0; i < this.products.length; i++) {
        if (this.products[i].productId.toString() == productId) {
          flag = true;
          break;
        }
      }
    }
    return flag;
  }

  setCartCount(String count) {
    cartCount = count;
    notifyListeners();
  }
}
