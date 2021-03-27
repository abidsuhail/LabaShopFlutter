import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/order_model.dart';
import 'package:labashop_flutter_app/ui/fragments/order_details_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/my_orders_list_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/widgets/list_items/my_order_list_item.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class MyOrdersListAdapter extends StatefulWidget {
  const MyOrdersListAdapter({@required this.vm, @required this.callback});

  final MyOrdersListFragmentVm vm;
  final Function callback;
  @override
  _MyOrdersListAdapterState createState() => _MyOrdersListAdapterState();
}

class _MyOrdersListAdapterState extends State<MyOrdersListAdapter>
    implements ScreenCallback {
  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: widget.vm.getMyOrdersList(listener: this),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  //opening order details fragment
                  //UIHelper.showShortToast('clicked');
                  //widget.callback(true);
                  //TODO not refreshing:fix it
                  widget.vm
                      .getOrderDetails(
                          listener: this,
                          orderId: orderModelList[index].orderId)
                      .then((value) {
                    //widget.callback(false);
                    Provider.of<FragmentNotifier>(context, listen: false)
                        .setFargment(OrderDetailsFragment.ID, object: value);
                  });
                },
                child: MyOrderListItem(
                    orderModel: orderModelList[index], vm: widget.vm),
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
    );
  }

  @override
  void hideProgress() {
    /* setState(() {
      progress = false;
    }); */
  }

  @override
  void showProgress() {
/*     setState(() {
      progress = true;
    }); */
  }
  @override
  void onError(String message) {
    UIHelper.showShortToast(message);
  }
}
