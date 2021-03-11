import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';

class ProductsRepo extends Repository
{
  static ProductsRepo _mInstance;

  static ProductsRepo getInstance()
  {
    if(_mInstance==null)
    {
      _mInstance = new ProductsRepo();
    }
    return _mInstance;
  }

  Future<ResponseStatus> getProductsOnHome({pageNo, int pageSize}) async{
    String url = UrlProvider.getProductListHomeUrl(pageSize, pageNo);
    print(url);
    return networkManager.get(url: url);
  }
  Future<ResponseStatus> addToCart(Map<String,String> params) async{
    String url = UrlProvider.getAddToCartUrl();
    print(url);
    return networkManager.post(url: url,params: params);
  }
  Future<ResponseStatus> getCategories() async{
    String url = UrlProvider.getCategoryListUrl();
    print(url);
    return networkManager.get(url: url);
  }
  Future<ResponseStatus> getBanners() async{
    String url = UrlProvider.getBannerListUrl();
    print(url);
    return networkManager.get(url: url);
  }
}