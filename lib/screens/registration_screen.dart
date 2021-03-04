import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/model/userlist.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/login_screen_vm.dart';
import 'package:labashop_flutter_app/viewmodels/register_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/login_signup_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();

  static startScreen(BuildContext context)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> implements ScreenCallback {
  String name, mobile,email,password;
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: EdgeInsets.all(30),
                child: Image.asset('images/logo.png')),
            Text(
              'Customer Registration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginSignupTextField(
                  hintTxt: 'Name',
                  onChanged: (name) {
                    this.name = name;
                  },
                ),
                LoginSignupTextField(
                  hintTxt: 'Mobile ',
                  onChanged: (mobile) {
                    this.mobile = mobile;
                  },
                ),
                LoginSignupTextField(
                  hintTxt: 'Email Address ',
                  onChanged: (email) {
                    this.email = email;
                  },
                ),
                LoginSignupTextField(
                  hintTxt: 'Password ',
                  onChanged: (password) {
                    this.password = password;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: FlatButton(
                    padding: EdgeInsets.all(18),
                    onPressed: () {
                      //now login
                      startRegistrationProcess();
                    },
                    child: Text('Register', style: TextStyle(color: Colors.white)),
                    color: Color(AppColors.colorPrimary),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startRegistrationProcess() {
    RegisterScreenVm.getInstance().register(name: name,phone: mobile,email: email,password: password,listener: this,callback: (UserData userData)
    {
        //print(userList.users[0].authtoken);
      UIHelper.showShortToast('success ${userData.authtoken}');
    });
  }

  @override
  void onError(String message) {
    UIHelper.showShortToast(message);
  }

  @override
  void showProgress() {
    setState(() {
      progress = true;
    });
  }

  @override
  void hideProgress() {
    setState(() {
      progress = false;
    });
  }
}
