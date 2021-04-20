import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:provider/provider.dart';

class AboutUsFragment extends StatefulWidget {
  static const ID = 'AboutUsFragment';
  @override
  _AboutUsFragmentState createState() => _AboutUsFragmentState();
}

class _AboutUsFragmentState extends State<AboutUsFragment>
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
            UIHelper.getHtmlUnscapeString('About Us'),
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            UIHelper.getHtmlUnscapeString(
                'Hello and welcome to thelabashopping.com, the place to find the best and economical products and much more coming soon, for every taste and occasion. We thoroughly check the quality of our goods, working only with reliable suppliers so that you only receive the best quality product.\n\nWe at Laba Shopping, believe in high quality and exceptional customer service. But most importantly, we believe shopping is a right, not a luxury, so we strive to deliver the best products at the most affordable prices, and ship them to you regardless of where you are located.\n\nWe aim to offer our customers a variety of the latest Designs. We’ve come a long way, so we know exactly which direction to take when supplying you with high quality yet budget friendly products.\n\nWe offer all of this while providing excellent customer service and friendly support.We always keep an eye on the latest trends in products and put our customers’ wishes first. That is why we have satisfied customers all over the Country.The interests of our customers are always the top priority for us, so we hope you will enjoy our products as much as we enjoy making them available to you.\n\nThanks\nTeam Laba Shopping '),
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.start,
          ),
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
