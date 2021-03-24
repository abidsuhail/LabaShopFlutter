import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/ui/fragments/payment_fragment.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/select_delivery_option_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/address_list_item.dart';
import 'package:provider/provider.dart';

class AddressListAdapter extends StatelessWidget implements ScreenCallback {
  const AddressListAdapter({
    this.vm,
  });

  final SelectDeliveryOptionFragmentVm vm;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Address>>(
      future: vm.getAddress(listener: this),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Address> address = snapshot.data;
          return ListView.separated(
            shrinkWrap: true,
            itemCount: address != null ? address.length : 0,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 2,
                color: Colors.grey,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    AppSharedPrefs.saveSelectAddress(
                        jsonEncode(address[index]));

                    Provider.of<FragmentNotifier>(context, listen: false)
                        .setFargment(PaymentFragment.ID);
                  },
                  child: AddressListItem(address: address, index: index));
            },
          );
        }
        return Text('No Address!!');
      },
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
