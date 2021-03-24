import 'dart:convert';

import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static const String AUTH_TOKEN = 'authtoken';
  static const String CART_JSON = 'cart_json';
  static const String USER_JSON = 'user_json_encoded';
  static const String TOTAL_PAYABLE_AMOUNT = 'total';
  static const String SYNC_AUTH_TOKEN = 'synchonous_auth_token';
  static const String SELECTED_ADDRESS = 'address';
  static String syncAuthToken;
  static Future<bool> initSynchronousAuthToken() async {
    if (syncAuthToken == null) {
      syncAuthToken = await AppSharedPrefs.getAuthToken();
    }
    return syncAuthToken != null;
  }

  static String getSyncAuthToken() => syncAuthToken;

  static Future<SharedPreferences> getInstance() async =>
      await SharedPreferences.getInstance();

  static void saveAuthToken(String authToken) async {
    (await getInstance()).setString(AUTH_TOKEN, authToken);
  }

  static void saveCartJSON(String cartJson) async {
    (await getInstance()).setString(CART_JSON, cartJson);
  }

  static void saveTotalPayableAmt(String total) async {
    (await getInstance()).setString(TOTAL_PAYABLE_AMOUNT, total);
  }

  static void saveSelectAddress(String jsonAddress) async {
    (await getInstance()).setString(SELECTED_ADDRESS, jsonAddress);
  }

  static Future<Address> getSelectedAddress() async {
    return Address.fromJson(
        jsonDecode((await getInstance()).getString(SELECTED_ADDRESS)));
  }

  static Future<String> getTotalPayableAmt() async {
    return (await getInstance()).getString(TOTAL_PAYABLE_AMOUNT);
  }

  static Future<CartModel> getCartModel() async {
    String cartJsonStr = (await getInstance()).get(CART_JSON);
    return CartModel.fromJson(jsonDecode(cartJsonStr));
  }

  static void saveUserEncodedJSON(String userJsonEncoded) async {
    (await getInstance()).setString(USER_JSON, userJsonEncoded);
  }

  static Future<User> getUserFromDb() async {
    SharedPreferences prefs = (await getInstance());
    if (prefs.containsKey(USER_JSON)) {
      return User.fromJson(jsonDecode(prefs.getString(USER_JSON)));
    } else {
      return null;
    }
  }

  static Future<String> getAuthToken() async {
    SharedPreferences prefs = (await getInstance());
    return prefs.containsKey(AUTH_TOKEN) ? prefs.getString(AUTH_TOKEN) : '';
  }

  static Future<bool> removeAllPrefs() async {
    SharedPreferences prefs = (await getInstance());
    return await prefs.clear();
  }
}
