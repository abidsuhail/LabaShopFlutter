import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/banner.dart' as AppBanners;
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/repositories/productsrepo.dart';

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

  Future<List<Product>> getProductsOnHome({@required ScreenCallback listener,@required pageNo, @required int pageSize}) async{
    listener.showProgress();
    ResponseStatus responseStatus = await productsRepo.getProductsOnHome(pageNo:pageNo,pageSize:pageSize);
    listener.hideProgress();
    if(responseStatus!=null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<Product> products = responseParser.getProductList(responseStatus.getData()).products;
        /*ProductList.fromJson(responseStatus.getData()['products']);*/ //TODO CART KEY IS ALSO HERE
        return products;
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

    Future<List<Category>> getCategories({@required ScreenCallback listener}) async{
      listener.showProgress();
      ResponseStatus responseStatus = await productsRepo.getCategories();
      listener.hideProgress();
      if(responseStatus!=null) {
        if (responseStatus.getError() == NetworkConstants.OK) {
          List<Category> product = responseParser.getCategoryList(responseStatus.getData()).categories;
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
    Future<List<AppBanners.Banner>> getBanners({@required ScreenCallback listener}) async{
      listener.showProgress();
      ResponseStatus responseStatus = await productsRepo.getBanners();
      listener.hideProgress();
      if(responseStatus!=null) {
        if (responseStatus.getError() == NetworkConstants.OK) {
          List<AppBanners.Banner> product = responseParser.getBannersList(responseStatus.getData()).banners;
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