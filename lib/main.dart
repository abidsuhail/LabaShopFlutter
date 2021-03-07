
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/screens/home_screen.dart';
import 'package:labashop_flutter_app/screens/login_screen.dart';
import 'package:labashop_flutter_app/screens/splash_screen.dart';
import 'file:///E:/FlutterProjects/labashop_flutter_app/lib/widgets/home_content.dart';
import 'package:labashop_flutter_app/widgets/laba_appbars.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';

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













