import 'dart:convert';

import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/model/userlist.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/responseparser.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/repositories/authrepo.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

class LoginScreenVm
{
    AuthRepo authRepo = AuthRepo.getInstance();

    static LoginScreenVm _mInstance;
    ResponseParser responseParser = ResponseParser.getInstance();
    static LoginScreenVm getInstance()
    {
        if(_mInstance == null)
          {
            _mInstance = new LoginScreenVm();
          }
        return _mInstance;
    }

    //TODO Return something
    Future<User> authenticateUser({String username,String password,Function callback, ScreenCallback listener}) async{
      listener.showProgress();
      ResponseStatus responseStatus = await authRepo.authenticateUser(username: username,password: password);
      listener.hideProgress();
      if(responseStatus!=null) {
        if (responseStatus.getError() == NetworkConstants.OK) {
          User user = responseParser.getUser(responseStatus.getUser());
          AppSharedPrefs.saveAuthToken(user.authtoken);
          return user;
        } else {
          //error = 1
          listener.onError(responseStatus.getMessage());
        }
      }
      else{
        //unknown error
        listener.onError('Unknown Error');
      }
    }
}