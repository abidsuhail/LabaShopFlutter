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

  Future<ResponseStatus> getProductsOnHome() async{
    String url = UrlProvider.getProductListHomeUrl(10, 1);
    print(url);
    return networkManager.get(url: url);
  }
  Future<ResponseStatus> getCategories() async{
    String url = UrlProvider.getCategoryListUrl();
    print(url);
    return networkManager.get(url: url);
  }
}