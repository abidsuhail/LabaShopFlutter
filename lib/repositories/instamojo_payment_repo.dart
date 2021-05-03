import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/payment_request_model.dart';
import 'package:labashop_flutter_app/networking/networkconstants.dart';
import 'package:labashop_flutter_app/networking/repository.dart';
import 'package:labashop_flutter_app/networking/urlprovider.dart';

class InstamojoPaymentRepo extends Repository {
  static InstamojoPaymentRepo _mInstance;

  static InstamojoPaymentRepo getInstance() {
    if (_mInstance == null) {
      _mInstance = new InstamojoPaymentRepo();
    }
    return _mInstance;
  }

  Future<PaymentRequestModel> initInstamojoPaymentRequest(
      {ScreenCallback listener, Map<String, String> params}) async {
    listener.showProgress();
    String url = UrlProvider.getInitInstamojoReqUrl();
    print(url);
    PaymentRequestModel responseStatus =
        await networkManager.initInstamojoReq(url: url, params: params);
    listener.hideProgress();

    if (responseStatus != null) {
      if (responseStatus.error == NetworkConstants.OK) {
        return responseStatus;
      } else {
        //error = 1
        listener.onError(responseStatus.message);
      }
    } else {
      //unknown error
      listener.onError('Unknown Error');
    }
  }
}
