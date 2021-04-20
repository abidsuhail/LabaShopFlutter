import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';

class UserRepo extends Repository {
  static UserRepo _mInstance;

  static UserRepo getInstance() {
    if (_mInstance == null) {
      _mInstance = new UserRepo();
    }
    return _mInstance;
  }

  Future<List<Address>> getAddress({ScreenCallback listener}) async {
    listener.showProgress();
    String url = UrlProvider.getAddressUrl();
    print(url);
    ResponseStatus responseStatus = await networkManager.get(url: url);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        List<Address> product =
            responseParser.getAddress(responseStatus.getData());
        return product;
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }

  Future<String> addNewAddress(
      {ScreenCallback listener, Map<String, String> params}) async {
    listener.showProgress();
    String url = UrlProvider.addAddressUrl();
    print(url);
    ResponseStatus responseStatus =
        await networkManager.post(url: url, params: params);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        return responseStatus.getMessage();
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }

  Future<String> changePassword(
      {ScreenCallback listener, Map<String, String> params}) async {
    listener.showProgress();
    String url = UrlProvider.getUpdatePasswordUrl();
    print(url);
    ResponseStatus responseStatus =
        await networkManager.post(url: url, params: params);
    listener.hideProgress();
    if (responseStatus != null) {
      if (responseStatus.getError() == NetworkConstants.OK) {
        return responseStatus.getMessage();
      } else {
        //error = 1
        listener.onError(responseStatus.getMessage());
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }
}
