import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';

class LabaAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(33),
      child: Image(image: AssetImage('images/logowhite_top.png')),
    );
  }
}
class LabaSearchAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.all(0),
      title: Container(
          alignment: AlignmentDirectional.bottomCenter,
          margin: EdgeInsets.symmetric(horizontal: 7,vertical: 7),
          child: SearchTextField()),
      centerTitle: true,
    );
  }
}