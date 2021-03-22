import 'dart:convert';

import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/banner.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

class ProductsRepo extends Repository {
  static ProductsRepo _mInstance;

  static ProductsRepo getInstance() {
    if (_mInstance == null) {
      _mInstance = new ProductsRepo();
    }
    return _mInstance;
  }

  Future<List<Product>> getProductsOnHome(
      {pageNo, int pageSize, ScreenCallback listener}) async {
    listener.showProgress();

    String url = UrlProvider.getProductListHomeUrl(pageSize, pageNo);
    print(url);
    ResponseStatus responseStatus = await networkManager.get(url: url);
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

  Future<String> addToCart(String sid, String pid, String qty, String cost,
      String size, String single,
      {ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getAddToCartUrl();
    print(url);
    Map<String, String> params = new Map<String, String>();
    params['sid'] = sid;
    params['pid'] = pid;
    params['qty'] = qty;
    params['cost'] = cost;
    params['size'] = size;
    params['single'] = single;
    print(
        '-------------------(sid = $sid) (pid = $pid) (qty = $qty) (cost = $cost) (size = $size) (single = $single)---------------');
    ResponseStatus responseStatus =
        await networkManager.post(url: url, params: params);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        return responseStatus.getMessage();
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }

  Future<List<Category>> getCategories({ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getCategoryListUrl();
    print(url);
    ResponseStatus responseStatus = await networkManager.get(url: url);
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

  Future<List<Banner>> getBanners({ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getBannerListUrl();
    print(url);
    ResponseStatus responseStatus = await networkManager.get(url: url);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<Banner> product =
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

  Future<List<Product>> getCart({ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getCartUrl();
    print(url);
    ResponseStatus responseStatus = await networkManager.get(url: url);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<Product> product =
            responseParser.getProductList(responseStatus.getData()).products;
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
}
