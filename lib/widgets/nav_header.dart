import 'package:flutter/material.dart';

class NavHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text("Ashish Rawat"),
      accountEmail: Text("ashishrawat2911@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
        child: Text(
          "A",
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}