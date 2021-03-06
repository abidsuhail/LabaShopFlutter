import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/model/userlist.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/responseparser.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

import 'base/view_model.dart';

class HomeScreenVm extends ChangeNotifier with ViewModel
{
    ProductsRepo productsRepo = ProductsRepo.getInstance();
    static HomeScreenVm _mInstance;
    static HomeScreenVm getInstance()
    {
        if(_mInstance == null)
          {
            _mInstance = new HomeScreenVm();
          }
        return _mInstance;
    }

  Future<ProductList> getProductsOnHome({@required ScreenCallback listener}) async{
    listener.showProgress();
    ResponseStatus responseStatus = await productsRepo.getProductsOnHome();
    listener.hideProgress();
    if(responseStatus!=null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        ProductList product = ProductList.fromJson(responseStatus.getData()['products']); //TODO CART KEY IS ALSO HERE
        return product;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    }
    else{
      //unknown error
      listener.onError('Unknown Error');
    }
  }

    Future<CategoryList> getCategories({@required ScreenCallback listener}) async{
      listener.showProgress();
      ResponseStatus responseStatus = await productsRepo.getProductsOnHome();
      listener.hideProgress();
      if(responseStatus!=null) {
        if (responseStatus.getError() == NetworkConstants.OK) {
          CategoryList product = CategoryList.fromJson(responseStatus.getData()); //TODO CART KEY IS ALSO HERE
          return product;
        } else {
          //error = 1
          listener.onError(responseStatus.getMessage());
        }
      }
      else{
        //unknown error
        listener.onError('Unknown Error');
      }
    }
}