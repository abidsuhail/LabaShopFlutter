import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double padding;
  const LoginButton(
      {@required this.text, @required this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: FlatButton(
        padding: EdgeInsets.all(padding ?? 18),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
        color: Color(AppColors.colorPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
