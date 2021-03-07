import 'dart:async';

import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/ui/screens/home_screen.dart';
import 'package:labashop_flutter_app/ui/screens/login_screen.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _loadWidget() async {
    var _duration = Duration(seconds: 3);
    Timer(_duration, ()async{

      if(await AppSharedPrefs.getAuthToken()!='') {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen()));

        //TODO change start screen in each activity like startNewIntent
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(35),
        child: Center(
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }
}
