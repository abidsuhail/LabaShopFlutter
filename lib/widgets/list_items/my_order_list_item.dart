import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/model/order_model.dart';
import 'package:labashop_flutter_app/widgets/login_btn.dart';
import 'package:labashop_flutter_app/widgets/product_widgets.dart';

class MyOrderListItem extends StatelessWidget {
  final OrderModel orderModel;
  MyOrderListItem({this.orderModel});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Order Number : ${orderModel.orderNumber}',
            style: TextStyle(fontSize: 15, color: AppColors.colorPrimaryObj),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            orderModel.payableAmount,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            orderModel.paymentMode,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            orderModel.postedOn,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${orderModel.itemCount.toString()} items',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              //TODO cancel order
            },
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
          )
        ]));
  }
}
