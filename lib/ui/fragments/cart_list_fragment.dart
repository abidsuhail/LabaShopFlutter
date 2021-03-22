import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:provider/provider.dart';

class CartListFragment extends StatefulWidget {
  @override
  _CartListFragmentState createState() => _CartListFragmentState();
}

class _CartListFragmentState extends State<CartListFragment>
    implements ScreenCallback {
  CartListFragmentVm vm;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CartListFragmentVm>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cart',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          textAlign: TextAlign.start,
        ),
        FutureBuilder<List<Product>>(
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none &&
                projectSnap.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container(
                color: Colors.amber,
                height: 5,
                width: 5,
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount:
                    projectSnap.data != null ? projectSnap.data.length : 0,
                itemBuilder: (context, index) {
                  Product product = projectSnap.data[index];
                  return ProductListItem(
                    product: product,
                    pos: index,
                    products: projectSnap.data,
                  );
                },
              ),
            );
          },
          future: vm.getCartList(listener: this),
        )
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
