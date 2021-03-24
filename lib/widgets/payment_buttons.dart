import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';

class PaymentButton extends StatelessWidget {
  final String txt;
  final Function onPressed;

  const PaymentButton({this.txt, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlatButton(
          padding: EdgeInsets.all(15),
          color: AppColors.colorPrimaryObj,
          child: Text(
            txt,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onPressed),
    );
  }
}
