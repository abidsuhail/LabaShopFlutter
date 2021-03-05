import 'package:flutter/material.dart';

class LoginSignupTextField extends StatelessWidget {

  final String hintTxt;
  final Function onChanged;

  LoginSignupTextField({this.hintTxt,this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: TextField(
          onChanged: onChanged,
          autofocus: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: hintTxt,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 2),
                borderRadius: BorderRadius.circular(8),
              )
          ),
        ));
  }
}