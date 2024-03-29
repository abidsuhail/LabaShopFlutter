import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs extends ChangeNotifier
{
  static const String AUTH_TOKEN = 'authtoken';
  static const String USER_JSON = 'user_json_encoded';
  static Future<SharedPreferences> getInstance() async => await SharedPreferences.getInstance();

  static void saveAuthToken(String authToken) async
  {
    (await getInstance()).setString(AUTH_TOKEN, authToken);
  }
  static void saveUserEncodedJSON(String userJsonEncoded) async
  {
    (await getInstance()).setString(USER_JSON, userJsonEncoded);
  }
  static Future<User> getUserFromDb() async
  {
    SharedPreferences prefs = (await getInstance());
    if(prefs.containsKey(USER_JSON)) {
      return User.fromJson(jsonDecode(prefs.getString(USER_JSON)));
    }else{
      return null;
    }
  }
  static Future<String> getAuthToken() async
  {
    SharedPreferences prefs = (await getInstance());
    return prefs.containsKey(AUTH_TOKEN)?prefs.getString(AUTH_TOKEN):'';
  }

  static Future<bool> removeAllPrefs() async{
    SharedPreferences prefs = (await getInstance());
    return await prefs.clear();
  }
}