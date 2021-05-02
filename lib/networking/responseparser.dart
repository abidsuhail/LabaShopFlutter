import 'dart:convert';

import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/model/banner.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/model/order_model.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';

class ResponseParser {
  static ResponseParser _mInstance;
  static ResponseParser getInstance() {
    if (_mInstance == null) {
      _mInstance = ResponseParser();
    }
    return _mInstance;
  }

  ResponseStatus getResponseStatus(String response) {
    print('responseparser : $response');
    ResponseStatus returnValue = new ResponseStatus();
    try {
      Map<String, dynamic> jsonMap = jsonDecode(response);
      returnValue.setError(jsonMap['error'] as int);
      if (jsonMap.containsKey('message'))
        returnValue.setMessage(jsonEncode(jsonMap['message']));
      if (jsonMap.containsKey('user'))
        returnValue.setUser(jsonEncode(jsonMap['user']));
      if (jsonMap.containsKey('data'))
        returnValue.setData(jsonEncode(jsonMap['data']));
    } catch (e) {
      print('responseparser : $e');
    }
    return returnValue;
  }

  User getUser(String data) {
    return User.fromJson(jsonDecode(data));
  }

  ProductList getProductList(String data) {
    return ProductList.fromJson(jsonDecode(data)['products']);
  }

  CategoryList getCategoryList(String data) {
    return CategoryList.fromJson(jsonDecode(data));
  }

  BannerList getBannersList(String data) {
    return BannerList.fromJson(jsonDecode(data));
  }

  CartModel getCart(String data) {
    return CartModel.fromJson(jsonDecode(data)['cart']);
  }

  List<Address> getAddress(String data) {
    return AddressList.fromJson(jsonDecode(data)).address;
  }

  List<OrderDetails> getOrderDetailsList(String data) {
    return OrderDetailsList.fromJson(jsonDecode(data)).orderDetails;
  }

  List<OrderModel> getMyOrdersList(String data) {
    return OrderModelList.fromJson(jsonDecode(data)).orderModels;
  }

  String getOrderId(String data) {
    return jsonDecode(data)['order_id'];
  }
}
