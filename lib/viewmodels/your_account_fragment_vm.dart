import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';
import 'package:labashop_flutter_app/repositories/userrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/viewmodels/base/view_model.dart';

class YourAccountFragmentVm extends ChangeNotifier with ViewModel {
  UserRepo authRepo = UserRepo.getInstance();

  static YourAccountFragmentVm _mInstance;
  static YourAccountFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new YourAccountFragmentVm();
    }
    return _mInstance;
  }

  //TODO Return something
  Future<String> changePassword(
      {String oldPass,
      String newPass,
      Function callback,
      ScreenCallback listener}) async {
    Map<String, String> params = Map();
    params['authtoken'] = await AppSharedPrefs.getAuthToken();
    params['old_password'] = oldPass;
    params['new_password'] = newPass;

    return await authRepo.changePassword(listener: listener, params: params);
  }
}
