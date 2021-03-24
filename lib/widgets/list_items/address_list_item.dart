import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/ui/fragments/payment_fragment.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:provider/provider.dart';

class AddressListItem extends StatelessWidget {
  const AddressListItem({
    @required this.address,
    @required this.index,
  });

  final List<Address> address;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${address[index].name}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text('${address[index].address1}'),
          SizedBox(
            height: 5,
          ),
          Text('${address[index].address2}'),
          SizedBox(
            height: 5,
          ),
          Text('Landmark : ${address[index].landmark}'),
          SizedBox(
            height: 5,
          ),
          Text(
              '${address[index].city} ${address[index].state} ${address[index].country} Postcode : ${address[index].pin}'),
        ],
      ),
    );
  }
}
