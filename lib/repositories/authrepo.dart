import 'package:flutter/cupertino.dart';
import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';

class AuthRepo extends Repository
{
  static AuthRepo _mInstance;

  static AuthRepo getInstance()
  {
    if(_mInstance==null)
      {
        _mInstance = new AuthRepo();
      }
    return _mInstance;
  }

  Future<ResponseStatus> authenticateUser({String username,String password,Function callback}) async{
    String url = UrlProvider.getAuthenticateUserUrl();
    Map<String,String> params = {'username':username,'password':password};
    print(url);
    return networkManager.post(url: url,params:params);
  }
  Future<ResponseStatus> registerUser({String name,String phone,String email,String password,Function callback}) async{
    String url = UrlProvider.getRegisterUrl();
    Map<String,String> params = {'name':name,'phone':phone,'email':email,'password':password};
    print(url);
    return networkManager.post(url: url,params:params);
  }

}