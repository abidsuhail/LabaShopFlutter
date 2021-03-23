import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';

import 'base/view_model.dart';

class ShowCategoriesFragmentVm extends ChangeNotifier with ViewModel {
  ProductsRepo productsRepo = ProductsRepo.getInstance();
  static ShowCategoriesFragmentVm _mInstance;
  static ShowCategoriesFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new ShowCategoriesFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Category>> getCategories(
      {@required ScreenCallback listener}) async {
    return await productsRepo.getCategories(listener: listener);
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
}
