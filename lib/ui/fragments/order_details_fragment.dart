import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/ui/adapters/order_details_list_adapter.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/widgets/list_items/order_details_list_item.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:labashop_flutter_app/widgets/payment_buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class OrderDetailsFragment extends StatefulWidget {
  static const ID = 'OrderDetailsFragment';
  Object object;
  OrderDetailsFragment(this.object);

  @override
  _OrderDetailsFragmentState createState() => _OrderDetailsFragmentState();
}

class _OrderDetailsFragmentState extends State<OrderDetailsFragment>
    implements ScreenCallback {
  //OrderDetailsFragmentVm vm;

  String payableAmt;
  bool progress = false;
  List<OrderDetails> orderDetailsList;
  @override
  void initState() {
    // vm = Provider.of<OrderDetailsFragmentVm>(context, listen: false);
    if (widget.object is List<OrderDetails>) {
      orderDetailsList = widget.object;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /*   Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(SelectDeliveryOptionFragment.ID); */

        //TODO GOTO MY ORDERS,on back pressed
        return false;
      },
      child: ModalProgressHUD(
        inAsyncCall: progress,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                (orderDetailsList != null && orderDetailsList.length > 0)
                    ? orderDetailsList[0].orderNumber
                    : 'Invalid',
                style:
                    TextStyle(fontSize: 20, color: AppColors.colorPrimaryObj),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (orderDetailsList != null && orderDetailsList.length > 0)
                    ? 'Rs.${orderDetailsList[0].payableAmount}'
                    : 'Invalid',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (orderDetailsList != null && orderDetailsList.length > 0)
                    ? orderDetailsList[0].paymentMode
                    : 'Invalid',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                (orderDetailsList != null && orderDetailsList.length > 0)
                    ? orderDetailsList[0].postedOn
                    : 'Invalid',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
              ),
              OrderDetailsListAdapter(orderDetailsList: orderDetailsList),
              /* FutureBuilder(
                future: AppSharedPrefs.getTotalPayableAmt(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Amount Payable Rs. ${snapshot.data}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.start,
                      ),
                    );
                  }
                  return Container();
                },
              ), */
            ],
          ),
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
  void onError(String message) {
    UIHelper.showShortToast(message);
  }

  @override
  void showProgress() {
    setState(() {
      progress = true;
    });
  }
}
