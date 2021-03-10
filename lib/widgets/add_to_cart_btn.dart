import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';

class AddToCartButton extends StatelessWidget {
  final bool visibility;
  final Function onPressed;

  AddToCartButton({this.visibility, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: TextButton(
          onPressed: onPressed,
          child: Container(
            color: Color(AppColors.colorPrimary),
            padding: EdgeInsets.all(6),
            child: Text(
              'ADD',
              style: TextStyle(
                backgroundColor: Color(AppColors.colorPrimary),
                color: Colors.white,

              ),
            ),
          )
      ),
    );
  }
}