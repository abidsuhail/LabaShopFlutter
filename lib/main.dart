
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/ui/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(AppColors.colorPrimary),
        accentColor: Color(AppColors.colorPrimaryDark),
      ),
      home: SplashScreen(),
    );
  }
}













