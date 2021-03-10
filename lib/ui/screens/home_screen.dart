import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/widgets/cart_badge.dart';
import 'package:labashop_flutter_app/widgets/home_content.dart';
import 'package:labashop_flutter_app/widgets/laba_appbars.dart';
import 'package:labashop_flutter_app/widgets/nav_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget implements ScreenCallback {

  static startFreshScreen(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
        child: DrawerMenu(),
      ),
      appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          title: LabaAppBar(),
          actions: [
            Container(
              margin: EdgeInsets.all(5),
              child: CartBadge(count : '5'),
            )
          ]
      ),
      body: HomeContent(),
    );
  }

  @override
  void hideProgress() {

  }

  @override
  void showProgress() {

  }

  @override
  void onError(String message) {
    print(message);
  }
}

