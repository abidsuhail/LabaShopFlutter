import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/address_list_adapter.dart';
import 'package:labashop_flutter_app/ui/fragments/add_new_address_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/select_delivery_option_fragment_vm.dart';
import 'package:provider/provider.dart';

class SelectDeliveryOptionFragment extends StatefulWidget {
  static const ID = 'SelectDeliveryOptionFragment';
  final Category category;
  SelectDeliveryOptionFragment({this.category});
  @override
  _SelectDeliveryOptionFragmentState createState() =>
      _SelectDeliveryOptionFragmentState();
}

class _SelectDeliveryOptionFragmentState
    extends State<SelectDeliveryOptionFragment> {
  SelectDeliveryOptionFragmentVm vm;
  @override
  void initState() {
    super.initState();
    vm = Provider.of<SelectDeliveryOptionFragmentVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(CartListFragment.ID);
        return false;
      },
      child: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            UIHelper.getHtmlUnscapeString('Select Delivery Option'),
            style: TextStyle(
              fontSize: 21,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        GestureDetector(
          onTap: () {
            Provider.of<FragmentNotifier>(context, listen: false)
                .setFargment(AddNewAddressFragment.ID);
          },
          child: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(10),
            child: Text(
              UIHelper.getHtmlUnscapeString('Add New Address'),
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.colorPrimaryObj,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        AddressListAdapter(vm: vm),
      ]),
    );
  }
}
