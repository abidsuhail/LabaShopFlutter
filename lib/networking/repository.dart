import 'package:flutter/cupertino.dart';
import 'package:labashop_flutter_app/networking/networkmanager.dart';
import 'package:labashop_flutter_app/networking/responseparser.dart';

abstract class Repository {
  NetworkManager networkManager = NetworkManager.getInstance();

  ResponseParser responseParser = ResponseParser.getInstance();
}
