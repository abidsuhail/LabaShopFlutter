import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/address_list_adapter.dart';
import 'package:labashop_flutter_app/ui/fragments/add_new_address_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/your_account_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/select_delivery_option_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/login_btn.dart';
import 'package:labashop_flutter_app/widgets/login_signup_textfield.dart';
import 'package:provider/provider.dart';

class YourAccountFragment extends StatefulWidget {
  static const ID = 'YourAccountFragment';
  final Category category;
  YourAccountFragment({this.category});
  @override
  _YourAccountFragmentState createState() => _YourAccountFragmentState();
}

class _YourAccountFragmentState extends State<YourAccountFragment>
    implements ScreenCallback {
  YourAccountFragmentVm vm;

  bool changePasswordContentVisibility = false;
  String oldPass, newPass;
  @override
  void initState() {
    super.initState();
    vm = Provider.of<YourAccountFragmentVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false).navigatedBack();

        return false;
      },
      child: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            UIHelper.getHtmlUnscapeString('Account Settings'),
            style: TextStyle(
              fontSize: 21,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  changePasswordContentVisibility =
                      !changePasswordContentVisibility;
                });
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          UIHelper.getHtmlUnscapeString('Change your password'),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Stack(
                        children: [
                          Visibility(
                              visible: !changePasswordContentVisibility,
                              child: Icon(Icons.keyboard_arrow_right)),
                          Visibility(
                              visible: changePasswordContentVisibility,
                              child: Icon(Icons.keyboard_arrow_down)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: changePasswordContentVisibility,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (oldPass) {
                        this.oldPass = oldPass;
                      },
                      decoration: InputDecoration(hintText: 'Old Password'),
                    ),
                    TextField(
                      onChanged: (newPass) {
                        this.newPass = newPass;
                      },
                      decoration: InputDecoration(hintText: 'New Password'),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: LoginButton(
                          text: 'Update',
                          onPressed: () {
                            vm
                                .changePassword(
                                    oldPass: oldPass,
                                    newPass: newPass,
                                    listener: this)
                                .then((value) {
                              UIHelper.showShortToast(value);
                            });
                          },
                          padding: 0,
                        )),
                        Expanded(
                            child: LoginButton(
                          text: 'Cancel',
                          onPressed: () {
                            setState(() {
                              changePasswordContentVisibility = false;
                            });
                          },
                          padding: 0,
                        )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }
}
