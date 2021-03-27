import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/order_model.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/my_orders_list_fragment_vm.dart';

class MyOrderListItem extends StatefulWidget {
  final OrderModel orderModel;
  final MyOrdersListFragmentVm vm;
  final Function refreshCallback;

  MyOrderListItem({this.orderModel, this.vm, this.refreshCallback});

  @override
  _MyOrderListItemState createState() => _MyOrderListItemState();
}

class _MyOrderListItemState extends State<MyOrderListItem>
    implements ScreenCallback {
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'Order Number : ${widget.orderModel.orderNumber}',
            style: TextStyle(fontSize: 15, color: AppColors.colorPrimaryObj),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rs.${widget.orderModel.payableAmount}',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Text(
                '${widget.orderModel.orderStatus.toUpperCase() == 'PENDING' ? 'Processing' : widget.orderModel.orderStatus}',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.orderModel.paymentMode,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.orderModel.postedOn,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${widget.orderModel.itemCount.toString()} items',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              //cancelling order
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text('Are you sure want to cancel this order?'),
                    actions: [
                      GestureDetector(
                          onTap: () {
                            //do nothing
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'DISMISS',
                                style:
                                    TextStyle(color: AppColors.colorPrimaryObj),
                              ))),
                      GestureDetector(
                          onTap: () {
                            //cancel order
                            Navigator.pop(context);
                            widget.vm
                                .cancelOrder(
                                    listener: this,
                                    orderId: widget.orderModel.orderId)
                                .then((value) {
                              UIHelper.showShortToast(value);
                              setState(() {
                                //FOR REFRESHING
                                widget.refreshCallback(true);
                              });
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('CANCEL ORDER',
                                  style: TextStyle(
                                      color: AppColors.colorPrimaryObj))))
                    ],
                  );
                },
              );
            },
            child: Wrap(
              children: [
                Visibility(
                  visible:
                      widget.orderModel.orderStatus.toUpperCase() == 'PENDING',
                  child: Container(
                      child: Container(
                    color: Color(AppColors.colorPrimary),
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'CANCEL ORDER',
                      style: TextStyle(
                        backgroundColor: Color(AppColors.colorPrimary),
                        color: Colors.white,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          )
        ]));
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
