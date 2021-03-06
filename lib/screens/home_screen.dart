import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/widgets/home_content.dart';
import 'package:labashop_flutter_app/widgets/laba_appbar.dart';
import 'package:labashop_flutter_app/widgets/nav_header.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget  {

  static startFreshScreen(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements ScreenCallback {
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerMenu(),
      ),
      appBar: AppBar(
          title: LabaAppBar(),
          actions: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset('images/ic_cart.png',height: 25,width: 25,))
          ]
      ),
      body: HomeContent(),
    );
  }

  @override
  void hideProgress() {
    setState(() {
      progress = false;
    });
  }

  @override
  void showProgress() {
    setState(() {
      progress = true;
    });
  }

  @override
  void onError(String message) {
    print(message);
  }
}