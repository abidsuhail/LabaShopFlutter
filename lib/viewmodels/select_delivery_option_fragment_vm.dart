import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/repositories/userrepo.dart';

import 'base/view_model.dart';

class SelectDeliveryOptionFragmentVm extends ChangeNotifier with ViewModel {
  UserRepo userRepo = UserRepo.getInstance();
  static SelectDeliveryOptionFragmentVm _mInstance;
  static SelectDeliveryOptionFragmentVm getInstance() {
    if (_mInstance == null) {
      _mInstance = new SelectDeliveryOptionFragmentVm();
    }
    return _mInstance;
  }

  Future<List<Address>> getAddress({@required ScreenCallback listener}) async {
    return await userRepo.getAddress(listener: listener);
  }
}
