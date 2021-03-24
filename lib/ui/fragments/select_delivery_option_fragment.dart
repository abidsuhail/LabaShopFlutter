import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/address.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/products_by_cat_paging_list_adapter.dart';
import 'package:labashop_flutter_app/ui/fragments/add_new_address_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/cart_list_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/select_delivery_option_fragment_vm.dart';
import 'package:provider/provider.dart';

import 'home_content_fragment.dart';

class SelectDeliveryOptionFragment extends StatefulWidget {
  static const ID = 'SelectDeliveryOptionFragment';
  final Category category;
  SelectDeliveryOptionFragment({this.category});
  @override
  _SelectDeliveryOptionFragmentState createState() =>
      _SelectDeliveryOptionFragmentState();
}

class _SelectDeliveryOptionFragmentState
    extends State<SelectDeliveryOptionFragment> implements ScreenCallback {
  SelectDeliveryOptionFragmentVm vm;
  @override
  void initState() {
    vm = Provider.of<SelectDeliveryOptionFragmentVm>(context, listen: false);
    super.initState();
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
            //TODO: OPEN ADD NEW ADDRESS FRAGMENT
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
        FutureBuilder<List<Address>>(
          future: vm.getAddress(listener: this),
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Address> address = snapshot.data;
              return ListView.separated(
                itemCount: address.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 2,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Text('${address[index].name}');
                },
              );
            }
            return Text('No Address!!');
          },
        ),

        /* Container(
            height: 50,
            child: ListView.builder(
              itemCount: widget.category.subCat.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(UIHelper.getHtmlUnscapeString(
                        widget.category.subCat[index].subCategoryName)),
                  ),
                ));
              },
            ),
          ), */
      ]),
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
