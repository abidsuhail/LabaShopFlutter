import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

class AuthRepo extends Repository {
  static AuthRepo _mInstance;

  static AuthRepo getInstance() {
    if (_mInstance == null) {
      _mInstance = new AuthRepo();
    }
    return _mInstance;
  }

  Future<User> authenticateUser(
      {String username, String password, ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getAuthenticateUserUrl();
    Map<String, String> params = {'username': username, 'password': password};
    print(url);

    ResponseStatus responseStatus =
        await networkManager.post(url: url, params: params);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        User user = responseParser.getUser(responseStatus.getUser());
        AppSharedPrefs.saveAuthToken(user.authtoken);
        AppSharedPrefs.saveUserEncodedJSON(jsonEncode(user));
        return user;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }

  Future<User> registerUser(
      {String name,
      String phone,
      String email,
      String password,
      ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getRegisterUrl();
    print(url);
    Map<String, String> params = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    };
    ResponseStatus responseStatus =
        await networkManager.post(url: url, params: params);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        User user = responseParser.getUser(responseStatus.getUser());
        AppSharedPrefs.saveAuthToken(user.authtoken);

        AppSharedPrefs.saveUserEncodedJSON(jsonEncode(user));
        return user;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }
}
