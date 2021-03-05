import 'dart:convert';

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
        returnValue.setMessage(jsonMap['message']);
      if(jsonMap.containsKey('user'))
        returnValue.setUser(jsonMap['user']);
      if(jsonMap.containsKey('data'))
        returnValue.setData(jsonMap['data']);

    } catch (e) {
    print('responseparser : $e');
    }
    return returnValue;
  }

  UserData getUser(Map<String,dynamic> data)
  {
    return UserData.fromJson(data);
  }
}