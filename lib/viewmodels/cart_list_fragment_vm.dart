import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';

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
