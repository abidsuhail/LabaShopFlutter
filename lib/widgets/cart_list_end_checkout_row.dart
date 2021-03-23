import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';

class CartEndCheckoutRow extends StatelessWidget {
  final String leftTxt, rightTxt;
  CartEndCheckoutRow({@required this.leftTxt, @required this.rightTxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CartEndCheckoutContainer(
            txt: leftTxt,
            txtColor: Colors.white,
            decoration: BoxDecoration(
              color: Color(AppColors.colorPrimary),
            ),
          ),
          CartEndCheckoutContainer(
            txt: rightTxt,
            txtColor: Color(AppColors.colorPrimary),
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(
                AppColors.colorPrimary,
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class CartEndCheckoutContainer extends StatelessWidget {
  const CartEndCheckoutContainer({
    @required this.txt,
    @required this.txtColor,
    @required this.decoration,
  });

  final String txt;
  final Decoration decoration;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(12),
      decoration: decoration,
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: txtColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ));
  }
}
