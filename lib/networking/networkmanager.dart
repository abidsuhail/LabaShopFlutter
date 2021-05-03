import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labashop_flutter_app/model/payment_request_model.dart';
import 'package:labashop_flutter_app/networking/responseparser.dart';
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
  Map<String, String> getInstamojoPaymentHeader() {
    return {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Api-Key": "test_b5142df51424c67e02c92f6c366",
      "X-Auth-Token": 'test_21194bb80fc294b1127c174b82a',
      "Access-Control-Allow-Headers":
          "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With",
      "Access-Control-Allow-Methods": "DELETE, POST, GET, OPTIONS",
      "Access-Control-Allow-Origin": "*"
    };
  }

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

  Future<PaymentRequestModel> initInstamojoReq(
      {String url, Map<String, String> params}) async {
    try {
      var resp = await http.post(Uri.encodeFull(url),
          headers: getInstamojoPaymentHeader(), body: params);
      if (resp.statusCode == 201) {
        if (json.decode(resp.body)['success'] == true) {
          PaymentRequestModel model = PaymentRequestModel.fromJson(
              jsonDecode(resp.body)["payment_request"]);
          model.error = 0;
          model.message = '';
          return model;
        } else {
          PaymentRequestModel model = PaymentRequestModel();
          model.error = 1;
          model.message = 'Request Failed';
          return model;
        }
      } else {
        PaymentRequestModel model = PaymentRequestModel();
        model.error = 1;
        model.message = 'Unable to complete request';
        return model;
      }
    } catch (e) {
      PaymentRequestModel model = PaymentRequestModel();
      model.error = 1;
      model.message = e;
      return model;
    }
  }
}
