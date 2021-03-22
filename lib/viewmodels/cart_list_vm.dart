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
import 'package:labashop_flutter_app/utils/uihelper.dart';

import 'base/view_model.dart';

class CartListFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static CartListFragmentVm _mInstance;
  static CartListFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new CartListFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Product>> getCartList({@required ScreenCallback listener}) async {
    return productsRepo.getCart(listener: listener);
  }
}
