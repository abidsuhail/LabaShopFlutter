import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/utils/app_providers.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/widgets/cart_badge.dart';
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
  List<Widget> _fragments = [HomeContentFragment()];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: AppProviders.providers,
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
                              count:
                                  Provider.of<HomeScreenVm>(context).cartCount),
                        )
                      ]),
                  body: Scaffold(
                    appBar: AppBar(
                      flexibleSpace: LabaSearchAppBar(),
                      elevation: 0,
                      toolbarHeight: 65,
                    ),
                    body:
                        Provider.of<FragmentNotifier>(context).selectedFragment,
                  ),
                )));
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
