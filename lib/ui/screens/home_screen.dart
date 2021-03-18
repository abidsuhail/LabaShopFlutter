import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/cart_badge.dart';
import 'package:labashop_flutter_app/widgets/home_content.dart';
import 'package:labashop_flutter_app/widgets/laba_appbars.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static startFreshScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements ScreenCallback {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeScreenVm>(
            create: (context) => HomeScreenVm(),
          ),
        ],
        child: Builder(
          builder: (context) => Scaffold(
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
                    child: CartBadge(
                        count: Provider.of<HomeScreenVm>(context).cartCount),
                  )
                ]),
            body: HomeContent(),
          ),
        ));
  }

  @override
  void hideProgress() {}

  @override
  void showProgress() {}

  @override
  void onError(String message) {
    print(message);
  }
}
