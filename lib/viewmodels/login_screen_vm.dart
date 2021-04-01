import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';
import 'package:labashop_flutter_app/viewmodels/base/view_model.dart';

class LoginScreenVm extends ChangeNotifier with ViewModel {
  AuthRepo authRepo = AuthRepo.getInstance();

  static LoginScreenVm _mInstance;
  static LoginScreenVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new LoginScreenVm();
    }
    return _mInstance;
  }

  //TODO Return something
  Future<User> authenticateUser(
      {String username,
      String password,
      Function callback,
      ScreenCallback listener}) async {
    return await authRepo.authenticateUser(
        username: username, password: password, listener: listener);
  }
}
