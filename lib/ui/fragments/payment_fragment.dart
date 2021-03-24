import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/ui/fragments/select_delivery_option_fragment.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/widgets/payment_buttons.dart';
import 'package:provider/provider.dart';

class PaymentFragment extends StatefulWidget {
  static const ID = 'PaymentFragment';

  @override
  _PaymentFragmentState createState() => _PaymentFragmentState();
}

class _PaymentFragmentState extends State<PaymentFragment>
    implements ScreenCallback {
/*   PaymentFragmentVm vm; */

  String payableAmt;

  @override
  Widget build(BuildContext context) {
/*     vm = Provider.of<PaymentFragmentVm>(context); */
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(SelectDeliveryOptionFragment.ID);
        return false;
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Payment',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            FutureBuilder(
              future: AppSharedPrefs.getTotalPayableAmt(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Amount Payable Rs. ${snapshot.data}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.start,
                    ),
                  );
                }
                return Container();
              },
            ),
            Text(
              'Deliver To',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: FutureBuilder(
                future: AppSharedPrefs.getSelectedAddress(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Address address = snapshot.data;
                    return Text(
                      '${address.address1} , ${address.address2} , Landmark : ${address.address1}, ${address.city} , ${address.state} , ${address.country} , PIN:${address.pin}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.start,
                    );
                  }
                  return Container();
                },
              ),
            ),
            Text(
              'Payment Option',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            PaymentButton(
              txt: 'Cash On Delivery',
              onPressed: () {},
            ),
            PaymentButton(
              txt: 'Pay Now',
              onPressed: () {},
            )
          ],
        ),
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
