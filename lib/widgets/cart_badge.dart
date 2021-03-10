import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';

class CartBadge extends StatefulWidget {

  final String count;

  CartBadge({this.count});

  @override
  _CartBadgeState createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge: (widget.count==null || widget.count == '0')?false:true,
      borderSide: BorderSide(
          color: Colors.white
      ),
      position: BadgePosition.topStart(top: -5,start: 11),
      badgeContent: Text(widget.count,style: TextStyle(
          color: Colors.white
      ),),
      badgeColor: Color(AppColors.colorPrimary),
      child: Icon(Icons.shopping_cart,size: 32,),);
  }
}