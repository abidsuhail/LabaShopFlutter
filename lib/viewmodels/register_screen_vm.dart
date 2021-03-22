import 'package:flutter/cupertino.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';

import 'base/view_model.dart';

class RegisterScreenVm extends ChangeNotifier with ViewModel {
  AuthRepo authRepo = AuthRepo.getInstance();
  static RegisterScreenVm _mInstance;
  static RegisterScreenVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new RegisterScreenVm();
    }
    return _mInstance;
  }

  Future<User> register(
      {String name,
      String phone,
      String email,
      String password,
      @required ScreenCallback listener}) async {
    return authRepo.registerUser(
        name: name,
        phone: phone,
        email: email,
        password: password,
        listener: listener);
  }
}
