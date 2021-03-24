import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/menu/drawer_menu.dart';
import 'package:labashop_flutter_app/ui/fragments/add_new_address_fragment.dart';
import 'package:labashop_flutter_app/viewmodels/add_new_address_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/products_by_category_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/select_delivery_option_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/show_categories_fragment_vm.dart';
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
          ChangeNotifierProvider<ShowProductsByCatFragmentVm>(
            create: (context) => ShowProductsByCatFragmentVm(),
          ),
          ChangeNotifierProvider<ShowCategoriesFragmentVm>(
            create: (context) => ShowCategoriesFragmentVm(),
          ),
          ChangeNotifierProvider<SelectDeliveryOptionFragmentVm>(
            create: (context) => SelectDeliveryOptionFragmentVm(),
          ),
          ChangeNotifierProvider<AddNewAddressFragmentVm>(
            create: (context) => AddNewAddressFragmentVm(),
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
