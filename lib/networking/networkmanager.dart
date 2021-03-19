import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/networking/responseparser.dart';
import 'package:http/http.dart' as http;
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:logger/logger.dart';

class NetworkManager {
  static NetworkManager _mInstance;
  ResponseParser _mParser = ResponseParser.getInstance();
  var logger = Logger();
  static NetworkManager getInstance() {
    if (_mInstance == null) {
      _mInstance = new NetworkManager();
    }
    return _mInstance;
  }

  Map<String, String> _getHeaders() => {
        /*  'Accept': 'application/json', */
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
            'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      };

  Future<ResponseStatus> post(
      {@required String url,
      Map<String, String> params,
      Function callback}) async {
    try {
      var response = await http.post(url, body: params, headers: _getHeaders());
      if (response.statusCode == 200) {
        ResponseStatus responseStatus =
            _mParser.getResponseStatus(response.body);
        print('Response Code : ${response.statusCode}');

        return responseStatus;
      } else {
        ResponseStatus status = ResponseStatus();
        status.setData(null);
        status.setMessage('Server Error!!');
        status.setError(1);
        return status;
      }
      //callback(responseStatus);
    } catch (e) {
      print(e);
      ResponseStatus status = ResponseStatus();
      status.setData(null);
      status.setMessage(e);
      status.setError(1);
      callback(status);
      return status;
    }
  }

  Future<ResponseStatus> get({@required String url}) async {
    try {
      var response = await http.get(url, headers: _getHeaders());
      if (response.statusCode == 200) {
        ResponseStatus responseStatus =
            _mParser.getResponseStatus(response.body);
        print('Response Code : ${response.statusCode}');

        return responseStatus;
      } else {
        ResponseStatus status = ResponseStatus();
        status.setData(null);
        status.setMessage('Server Error!!');
        status.setError(1);
        return status;
      }
      //callback(responseStatus);
    } catch (e) {
      print(e);
      ResponseStatus status = ResponseStatus();
      status.setData(null);
      status.setMessage(e);
      status.setError(1);
      return status;
    }
  }
}
