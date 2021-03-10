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

class HomeScreen extends StatefulWidget{


  static startFreshScreen(BuildContext context)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  implements ScreenCallback  {
  String cartCount='0';

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
              child: CartBadge(count : cartCount),
            )
          ]
      ),
      body: HomeContent(cartCountCallback:(count){
        //TODO add setState
        setState(() {
          cartCount = count;
        });
      }),
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

