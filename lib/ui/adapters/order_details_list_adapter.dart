import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/widgets/list_items/order_details_list_item.dart';

class OrderDetailsListAdapter extends StatelessWidget {
  final List<OrderDetails> orderDetailsList;
  OrderDetailsListAdapter({@required this.orderDetailsList});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: orderDetailsList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 2,
          color: Colors.grey,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return OrderDetailsListItem(
          orderDetails: orderDetailsList[index],
        );
      },
    );
  }
}
