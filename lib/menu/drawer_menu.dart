import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/ui/screens/home_screen.dart';
import 'package:labashop_flutter_app/ui/screens/login_screen.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/widgets/nav_header.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserNotifier(),
      child: ListView(
        padding: const EdgeInsets.all(0.0), //to make transparent status bar
        children: <Widget>[
          NavHeader(),
          ListTile(
            onTap: () {
              Provider.of<FragmentNotifier>(context, listen: false)
                  .setFargment(FragmentNotifier.HOME_FRAGMENT);
              Navigator.pop(context);
            },
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Provider.of<FragmentNotifier>(context, listen: false)
                  .setFargment(FragmentNotifier.SHOP_BY_CATEGORY_FRAGMENT);
              Navigator.pop(context);
            },
            title: Text("Shop By Category"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Your Orders"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Wishlist"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Your Account"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Contact Us"),
          ),
          ListTile(
            onTap: () {},
            title: Text("About Us"),
          ),
          ListTile(
            onTap: () async {
              if (await AppSharedPrefs.removeAllPrefs()) {
                LoginScreen.startFreshScreen(context);
              }
            },
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
