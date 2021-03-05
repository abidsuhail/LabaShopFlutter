import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/user.dart';
import 'package:labashop_flutter_app/screens/registration_screen.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/login_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/login_signup_textfield.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements ScreenCallback {
  String username, password;
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: EdgeInsets.all(30),
                  child: Image.asset('images/logo.png')),
              Text(
                'Welcome to Laba Shopping',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginSignupTextField(
                    hintTxt: 'Enter Username',
                    onChanged: (username) {
                      this.username = username;
                    },
                  ),
                  LoginSignupTextField(
                    hintTxt: 'Enter Password',
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
                        startLoginProcess();
                      },
                      child: Text('Login', style: TextStyle(color: Colors.white)),
                      color: Color(AppColors.colorPrimary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Color(AppColors.colorPrimary)),
                    ),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Dont have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                GestureDetector(
                  onTap: ()
                  {
                    RegistrationScreen.startScreen(context);
                  },
                  child: Text(
                    'Create your profile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(AppColors.colorPrimary)),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void startLoginProcess() async{
    User userData = await LoginScreenVm.getInstance().authenticateUser(username: username, password: password, listener: this);
    Logger().d('loginscreen',userData.authtoken);
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
