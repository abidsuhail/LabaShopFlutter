import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/wishlist_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:provider/provider.dart';

class ContactUsFragment extends StatefulWidget {
  static const ID = 'ContactUsFragment';
  @override
  _ContactUsFragmentState createState() => _ContactUsFragmentState();
}

class _ContactUsFragmentState extends State<ContactUsFragment>
    implements ScreenCallback {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /*   Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(CartListFragment.ID); */
        Provider.of<FragmentNotifier>(context, listen: false).navigatedBack();

        return false;
      },
      child: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            UIHelper.getHtmlUnscapeString('Contact Us'),
            style: TextStyle(
              fontSize: 23,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            UIHelper.getHtmlUnscapeString('Laba Shopping'),
            style: TextStyle(fontSize: 19, color: AppColors.colorPrimaryObj),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            UIHelper.getHtmlUnscapeString(
                "Plot No. 63, Pocket D,\nSector 10 (Near Mahavir Chowk) Vasundhara,\nGhaziabad Uttar Pradesh - 201012 "),
            style: TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            UIHelper.getHtmlUnscapeString('Mobile'),
            style: TextStyle(fontSize: 19, color: AppColors.colorPrimaryObj),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            UIHelper.getHtmlUnscapeString("+91 9310 448 414"),
            style: TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            UIHelper.getHtmlUnscapeString('Email'),
            style: TextStyle(fontSize: 19, color: AppColors.colorPrimaryObj),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            UIHelper.getHtmlUnscapeString("support@thelabashopping.com"),
            style: TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.start,
          ),
        )
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
