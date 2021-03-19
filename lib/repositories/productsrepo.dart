import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';

class ProductsRepo extends Repository {
  static ProductsRepo _mInstance;

  static ProductsRepo getInstance() {
    if (_mInstance == null) {
      _mInstance = new ProductsRepo();
    }
    return _mInstance;
  }

  Future<ResponseStatus> getProductsOnHome({pageNo, int pageSize}) async {
    String url = UrlProvider.getProductListHomeUrl(pageSize, pageNo);
    print(url);
    return networkManager.get(url: url);
  }

  Future<String> addToCart(String sid, String pid, String qty, String cost,
      String size, String single,
      {ScreenCallback listener}) async {
    String url = UrlProvider.getAddToCartUrl();
    print(url);
    listener.showProgress();
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

  Future<ResponseStatus> getCategories() async {
    String url = UrlProvider.getCategoryListUrl();
    print(url);
    return networkManager.get(url: url);
  }

  Future<ResponseStatus> getBanners() async {
    String url = UrlProvider.getBannerListUrl();
    print(url);
    return networkManager.get(url: url);
  }
}
