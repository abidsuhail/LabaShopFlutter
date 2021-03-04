import 'dart:convert';

import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/model/userlist.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';

class LoginScreenVm
{
    AuthRepo authRepo = AuthRepo.getInstance();

    static LoginScreenVm _mInstance;
    static LoginScreenVm getInstance()
    {
        if(_mInstance == null)
          {
            _mInstance = new LoginScreenVm();
          }
        return _mInstance;
    }

    void authenticateUser({String username,String password,Function callback, ScreenCallback listener}) async{
      listener.showProgress();
      authRepo.authenticateUser(username: username,password: password,callback: (ResponseStatus responseStatus)
      {
        listener.hideProgress();
          if(responseStatus!=null) {
            if (responseStatus.getError() == NetworkConstants.OK) {
             /* List<dynamic> decodedData = jsonDecode(
                  responseStatus.getData());
              UserList userData = UserList.fromJson(decodedData);
              callback(userData);*/
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