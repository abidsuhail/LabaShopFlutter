import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';

import 'base/view_model.dart';

class WishListFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static WishListFragmentVm _mInstance;
  static WishListFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new WishListFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Product>> getWishList({@required ScreenCallback listener}) async {
    return productsRepo.getWishList(listener: listener);
  }
}
