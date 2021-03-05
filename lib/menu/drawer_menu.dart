import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/screens/login_screen.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/widgets/nav_header.dart';

class DrawerMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0.0),  //to make transparent status bar
      children: <Widget>[
        NavHeader(),
        ListTile(
          onTap: (){

          },
          title: Text("Home"),
        ),
        ListTile(
          onTap: (){

          },
          title: Text("Shop By Category"),
        ),
        ListTile(
          onTap: (){

          },
          title: Text("Your Orders"),
        ),
        ListTile(
          onTap: (){

          },
          title: Text("Wishlist"),
        ),
        ListTile(
          onTap: (){

          },
          title: Text("Your Account"),
        ),
        ListTile(
          onTap: (){

          },
          title: Text("Contact Us"),
        ),
        ListTile(
          onTap: (){

          },
          title: Text("About Us"),
        ),
        ListTile(
          onTap: ()async {
            if(await AppSharedPrefs.removeAllPrefs())
              {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              }
          },
          title: Text("Logout"),
        )
      ],
    );
  }
}