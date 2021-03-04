import 'dart:convert';

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
    ResponseStatus returnValue = new ResponseStatus();
    try {
      var jsonDecodedBody = jsonDecode(response);
      var jsonMap = jsonDecodedBody as Map<String,dynamic>;
      returnValue.setError(jsonMap['error'] as int);
      if(jsonMap.containsKey('message'))
        returnValue.setMessage(jsonMap['message']);
      if(jsonMap.containsKey('user'))
        returnValue.setUser(jsonMap['user']);
      if(jsonMap.containsKey('data'))
        returnValue.setData(jsonMap['data']);
    } catch (e) {
    print(e);
    }
    return returnValue;
  }
}