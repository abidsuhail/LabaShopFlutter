import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';

import 'base/view_model.dart';

class ShowProductsByCatFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static ShowProductsByCatFragmentVm _mInstance;
  static ShowProductsByCatFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new ShowProductsByCatFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Product>> getProductsByCat(
      {String catId,
      String subCatId,
      String pageSize,
      String pageNo,
      @required ScreenCallback listener}) async {
    return await productsRepo.getProductsByCategory(
        catId: catId,
        subCatId: subCatId,
        pageSize: pageSize,
        pageNo: pageNo,
        listener: listener);
  }
}
