import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/ui/adapters/cart_list_adapter.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_vm.dart';
import 'package:provider/provider.dart';

class CartListFragment extends StatefulWidget {
  static const ID = 'CartListFragment';

  @override
  _CartListFragmentState createState() => _CartListFragmentState();
}

class _CartListFragmentState extends State<CartListFragment>
    implements ScreenCallback {
  CartListFragmentVm vm;

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CartListFragmentVm>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            'Cart',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        CartListAdapter(vm: vm),
      ],
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}