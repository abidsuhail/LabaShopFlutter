import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/order_details.dart';

class OrderDetailsListItem extends StatelessWidget {
  final OrderDetails orderDetails;
  OrderDetailsListItem({this.orderDetails});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 15),
        child: ListTile(
          leading: CachedNetworkImage(
            height: 120,
            width: 120,
            fit: BoxFit.contain,
            imageUrl: "${orderDetails.productImg[0]}",
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text(orderDetails.productName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${orderDetails.price.isNotEmpty ? orderDetails.price[0].size : 'N/A'} ${orderDetails.price.isNotEmpty ? orderDetails.price[0].unit : 'N/A'}'),
              SizedBox(
                height: 8,
              ),
              Text(
                  'Rs.${orderDetails.price.isNotEmpty ? orderDetails.price[0].cost : 'N/A'}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black)),
              SizedBox(
                height: 8,
              ),
              Text('Quantity : ${orderDetails.qty}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontStyle: FontStyle.italic))
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
