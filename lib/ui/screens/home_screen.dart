import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/shop_by_category_fragment.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_vm.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/viewmodels/shop_by_category_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/cart_badge.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
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
          ChangeNotifierProvider<CartListFragmentVm>(
            create: (context) => CartListFragmentVm(),
          ),
          ChangeNotifierProvider<FragmentNotifier>(
            create: (context) => FragmentNotifier(),
          ),
          ChangeNotifierProvider<ShopByCategoryFragmentVm>(
            create: (context) => ShopByCategoryFragmentVm(),
          )
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

class FragmentNotifier extends ChangeNotifier {
  static const HOME_FRAGMENT = 1;
  static const CART_LIST_FRAGMENT = 2;
  static const SHOP_BY_CATEGORY_FRAGMENT = 3;

  Widget selectedFragment;
  FragmentNotifier() {
    selectedFragment = HomeContentFragment();
  }
  void setFargment(int fragmentId) {
    switch (fragmentId) {
      case HOME_FRAGMENT:
        selectedFragment = HomeContentFragment();
        break;
      case CART_LIST_FRAGMENT:
        selectedFragment = CartListFragment();
        break;
      case SHOP_BY_CATEGORY_FRAGMENT:
        selectedFragment = ShopByCategoryFragment();
        break;
    }
    notifyListeners();
  }
}
