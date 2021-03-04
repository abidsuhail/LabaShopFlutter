import 'dart:async';

import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void _loadWidget() async {
    var _duration = Duration(seconds: 3);
    Timer(_duration, (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
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
