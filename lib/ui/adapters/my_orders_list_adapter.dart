import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/order_model.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/my_orders_list_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/my_order_list_item.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyOrdersListAdapter extends StatefulWidget {
  const MyOrdersListAdapter({
    @required this.vm,
  });

  final MyOrdersListFragmentVm vm;

  @override
  _MyOrdersListAdapterState createState() => _MyOrdersListAdapterState();
}

class _MyOrdersListAdapterState extends State<MyOrdersListAdapter>
    implements ScreenCallback {
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      child: FutureBuilder<List<OrderModel>>(
        future: widget.vm.getMyOrdersList(listener: this),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orderModelList = snapshot.data;
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 2,
              ),
              shrinkWrap: true,
              itemCount: orderModelList.length,
              itemBuilder: (BuildContext context, int index) {
                return MyOrderListItem(
                  orderModel: orderModelList[index],
                );
              },
            );
          }
          return Container(
            child: Center(
              child: Text('No Orders!!'),
            ),
          );
        },
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
