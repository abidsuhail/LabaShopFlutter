import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/fragments/select_delivery_option_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/widgets/login_btn.dart';
import 'package:labashop_flutter_app/widgets/login_signup_textfield.dart';
import 'package:provider/provider.dart';

class AddNewAddressFragment extends StatefulWidget {
  static const ID = 'AddNewAddressFragment';
  final Category category;
  AddNewAddressFragment({this.category});
  @override
  _ShowProductsByCatFragmentState createState() =>
      _ShowProductsByCatFragmentState();
}

class _ShowProductsByCatFragmentState extends State<AddNewAddressFragment>
    implements ScreenCallback {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(SelectDeliveryOptionFragment.ID);
        return false;
      },
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              UIHelper.getHtmlUnscapeString('Add New Address'),
              style: TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                LoginSignupTextField(
                  hintTxt: 'Name',
                ),
                LoginSignupTextField(
                  hintTxt: 'Address Line 1',
                ),
                LoginSignupTextField(
                  hintTxt: 'Address Line 2',
                ),
                LoginSignupTextField(
                  hintTxt: 'Landmark',
                ),
                LoginSignupTextField(
                  hintTxt: 'City',
                ),
                LoginSignupTextField(
                  hintTxt: 'State',
                ),
                LoginSignupTextField(
                  hintTxt: 'Country',
                ),
                LoginSignupTextField(
                  hintTxt: 'Postcode',
                ),
                LoginButton(
                    text: 'Submit',
                    onPressed: () {
                      //add new address
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
