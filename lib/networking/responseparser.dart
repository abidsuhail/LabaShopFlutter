import 'dart:convert';

import 'package:labashop_flutter_app/model/banner.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';


class ResponseParser
{
  static ResponseParser _mInstance;
  static ResponseParser getInstance()
  {
    if(_mInstance == null)
      {
        _mInstance = ResponseParser();
      }
    return _mInstance;
  }
  ResponseStatus getResponseStatus(String response) {
    print('responseparser : $response');
    ResponseStatus returnValue = new ResponseStatus();
    try {
      Map<String,dynamic> jsonMap = jsonDecode(response);
      returnValue.setError(jsonMap['error'] as int);
      if(jsonMap.containsKey('message'))
        returnValue.setMessage(jsonEncode(jsonMap['message']));
      if(jsonMap.containsKey('user'))
        returnValue.setUser(jsonEncode(jsonMap['user']));
      if(jsonMap.containsKey('data'))
        returnValue.setData(jsonEncode(jsonMap['data']));

    } catch (e) {
    print('responseparser : $e');
    }
    return returnValue;
  }

  User getUser(String data)
  {
    return User.fromJson(jsonDecode(data));
  }
  ProductList getProductList(String data)
  {
    return ProductList.fromJson(jsonDecode(data)['products']);
  }
  CategoryList getCategoryList(String data)
  {
    return CategoryList.fromJson(jsonDecode(data));
  }
  BannerList getBannersList(String data)
  {
    return BannerList.fromJson(jsonDecode(data));
  }
}