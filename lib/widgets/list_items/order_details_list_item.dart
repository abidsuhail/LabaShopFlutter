import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/order_details.dart';
import 'package:labashop_flutter_app/widgets/product_widgets.dart';

class OrderDetailsListItem extends StatelessWidget {
  final OrderDetails orderDetails;
  OrderDetailsListItem({this.orderDetails});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CachedNetworkImage(
              height: 120,
              width: 120,
              imageUrl: "${orderDetails.productImg[0]}",
              /*        placeholder: (context, url) => Padding(
                  padding: EdgeInsets.all(60),
                  child: CircularProgressIndicator()),*/
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitle(
                  productTitle: orderDetails.productName,
                  product: null,
                ),
                ProductSize(orderDetails: orderDetails, product: null),
              ],
            ),
          )
        ],
      ),
    );
  }
}
