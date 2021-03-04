import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/model/userlist.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';

class RegisterScreenVm
{
    AuthRepo authRepo = AuthRepo.getInstance();

    static RegisterScreenVm _mInstance;
    static RegisterScreenVm getInstance()
    {
        if(_mInstance == null)
          {
            _mInstance = new RegisterScreenVm();
          }
        return _mInstance;
    }

    void register({String name,String phone,String email,String password,@required Function callback, @required ScreenCallback listener}) async{
      listener.showProgress();
      authRepo.registerUser(name: name,phone:phone,email:email,password: password,callback: (ResponseStatus responseStatus)
      {
        listener.hideProgress();
          if(responseStatus!=null) {
            if (responseStatus.getError() == NetworkConstants.OK) {
              print(responseStatus.getUser());
              Map<String,dynamic> user = responseStatus.getUser();
              UserData userData = UserData.fromJson(user);
              callback(userData);
            } else {
              //error = 1
              listener.onError(responseStatus.getMessage());
            }
          }
          else{
            //unknown error
            listener.onError('Unknown Error');
          }
      });
    }
}