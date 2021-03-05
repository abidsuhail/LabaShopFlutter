import 'package:labashop_flutter_app/networking/responseparser.dart';
import 'package:http/http.dart' as http;
import 'package:labashop_flutter_app/networking/responsestatus.dart';
import 'package:logger/logger.dart';

class NetworkManager
{

  static NetworkManager _mInstance;
  ResponseParser _mParser = ResponseParser.getInstance();
  var logger = Logger();
  static NetworkManager getInstance()
  {
    if(_mInstance==null)
      {
        _mInstance = new NetworkManager();
      }
    return _mInstance;
  }


  Future<ResponseStatus> post({String url,Map<String,String> params,Function callback}) async
  {
    try {
      var response = await http.post(url, body: params,headers: {
        'Accept': 'application/json',});
      logger.d("networkmanager",response.body);
      ResponseStatus responseStatus = _mParser.getResponseStatus(
          response.body);
      print('Response Code : ${response.statusCode}');
      return responseStatus;
      //callback(responseStatus);
    }
    catch(e)
    {
      print(e);
      ResponseStatus status = ResponseStatus();
      status.setData(null);
      status.setMessage(e);
      status.setError(1);
      callback(status);
    }
  }
}