import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/repositories/userrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

import 'base/view_model.dart';

class AddNewAddressFragmentVm extends ChangeNotifier with ViewModel {
  UserRepo userRepo = UserRepo.getInstance();
  static AddNewAddressFragmentVm _mInstance;
  static AddNewAddressFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new AddNewAddressFragmentVm();
    }
    return _mInstance;
  }

  Future<String> addNewAddress(
      {@required ScreenCallback listener,
      String name,
      String address1,
      String address2,
      String landmark,
      String city,
      String state,
      String country,
      String postcode}) async {
    Map<String, String> params = Map<String, String>();
    params["authtoken"] = AppSharedPrefs.getSyncAuthToken();
    params["name"] = name;
    params["address1"] = address1;
    params["address2"] = address2;
    params["landmark"] = landmark;
    params["city"] = city;
    params["state"] = state;
    params["country"] = country;
    params["pin"] = postcode;
    return await userRepo.addNewAddress(listener: listener, params: params);
  }
}
