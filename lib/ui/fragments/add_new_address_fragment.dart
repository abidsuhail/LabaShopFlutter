import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/fragments/select_delivery_option_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/add_new_address_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/widgets/login_btn.dart';
import 'package:labashop_flutter_app/widgets/login_signup_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
  String name, address1, address2, landmark, city, state, country, postcode;
  AddNewAddressFragmentVm vm;
  bool progress = false;
  @override
  void initState() {
    vm = Provider.of<AddNewAddressFragmentVm>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      child: WillPopScope(
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
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  LoginSignupTextField(
                    hintTxt: 'Address Line 1',
                    onChanged: (value) {
                      address1 = value;
                    },
                  ),
                  LoginSignupTextField(
                      hintTxt: 'Address Line 2',
                      onChanged: (value) {
                        address2 = value;
                      }),
                  LoginSignupTextField(
                      hintTxt: 'Landmark',
                      onChanged: (value) {
                        landmark = value;
                      }),
                  LoginSignupTextField(
                      hintTxt: 'City',
                      onChanged: (value) {
                        city = value;
                      }),
                  LoginSignupTextField(
                      hintTxt: 'State',
                      onChanged: (value) {
                        state = value;
                      }),
                  LoginSignupTextField(
                      hintTxt: 'Country',
                      onChanged: (value) {
                        country = value;
                      }),
                  LoginSignupTextField(
                      hintTxt: 'Postcode',
                      onChanged: (value) {
                        postcode = value;
                      }),
                  LoginButton(
                      text: 'Submit',
                      onPressed: () {
                        //add new address
                        vm
                            .addNewAddress(
                                listener: this,
                                name: name,
                                address1: address1,
                                address2: address2,
                                landmark: landmark,
                                city: city,
                                state: state,
                                country: country,
                                postcode: postcode)
                            .then((msg) {
                          UIHelper.showShortToast(msg);
                          Provider.of<FragmentNotifier>(context, listen: false)
                              .setFargment(SelectDeliveryOptionFragment.ID);
                        });
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void hideProgress() {
    setState(() {
      progress = false;
    });
  }

  @override
  void onError(String message) {}

  @override
  void showProgress() {
    setState(() {
      progress = true;
    });
  }
}
