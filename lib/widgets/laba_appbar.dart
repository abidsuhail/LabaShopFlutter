import 'package:flutter/material.dart';

class LabaAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(33),
      child: Image(image: AssetImage('images/logowhite_top.png')),
    );
  }
}