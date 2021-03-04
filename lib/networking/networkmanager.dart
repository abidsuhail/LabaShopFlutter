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
      var response = await http.post(url, body: params);
      if (response.statusCode == 200)
      {
        ResponseStatus responseStatus = _mParser.getResponseStatus(
            response.body);
        callback(responseStatus);
      }
      else {
        print('Unknown Error Code : ${response.statusCode}');
      }
    }
    catch(e)
    {
      print(e);
    }
  }
}