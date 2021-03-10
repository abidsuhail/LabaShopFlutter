
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';

class ProductQtyButtonCounter extends StatelessWidget {
  final Function onPlusPressed,onMinusPressed;
  final bool visibility;
  final String count;


  ProductQtyButtonCounter({@required this.visibility,@required this.onPlusPressed,@required this.onMinusPressed,@required this.count});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            padding:EdgeInsets.all(10),
            child: Icon(Icons.horizontal_rule,color: Color(AppColors.colorPrimary)),
            onPressed: onMinusPressed,),
          Text(count),
          FlatButton(
            padding:EdgeInsets.all(10),
            child: Icon(Icons.add,color: Color(AppColors.colorPrimary),),
            onPressed: onPlusPressed,),
        ],
      ),);
  }
}