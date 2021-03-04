import 'package:labashop_flutter_app/networking/responseparser.dart';
import 'package:http/http.dart' as http;
import 'package:labashop_flutter_app/networking/responsestatus.dart';

class NetworkManager
{

  static NetworkManager _mInstance;
  ResponseParser _mParser = ResponseParser.getInstance();
  static NetworkManager getInstance()
  {
    if(_mInstance==null)
      {
        _mInstance = new NetworkManager();
      }
    return _mInstance;
  }


  void post({String url,Map<String,String> params,Function callback}) async
  {
    try {
      var response = await http.post(url, body: params,headers: {
        'Accept': 'application/json',});
      print('networkmanager ${response.body}');
      ResponseStatus responseStatus = _mParser.getResponseStatus(
          response.body);
      callback(responseStatus);
      print('Response Code : ${response.statusCode}');
    }
    catch(e)
    {
      print(e);
      ResponseStatus status = ResponseStatus();
      status.setData("");
      status.setMessage(e);
      status.setError(1);
      callback(status);
    }
  }
}