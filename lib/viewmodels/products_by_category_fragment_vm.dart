import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';

import 'base/view_model.dart';

class ProductsByCategoryFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static ProductsByCategoryFragmentVm _mInstance;
  static ProductsByCategoryFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new ProductsByCategoryFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Product>> getProductsByCat(
      String catId, String subCatId, String pageSize, String pageNo,
      {@required ScreenCallback listener}) async {
    return await productsRepo.getProductsByCategory(
        catId, subCatId, pageSize, pageNo,
        listener: listener);
  }
}
