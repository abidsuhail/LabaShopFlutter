import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_vm.dart';
import 'package:labashop_flutter_app/widgets/cart_list_end_checkout_row.dart';

import '../../widgets/list_items/product_list_item.dart';

class CartListAdapter extends StatefulWidget {
  const CartListAdapter({
    @required this.vm,
  });

  final CartListFragmentVm vm;

  @override
  _CartListAdapterState createState() => _CartListAdapterState();
}

class _CartListAdapterState extends State<CartListAdapter>
    implements ScreenCallback {
  double total = 0;

  Future<List<Product>> productsVm;

  @override
  void initState() {
    productsVm = widget.vm.getCartList(listener: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    total = 0;
    return FutureBuilder<List<Product>>(
      initialData: [],
      builder: (context, productSnap) {
        if (!productSnap.hasData || productSnap.data.isEmpty) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }
        return Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
                height: 2,
              );
            },
            itemCount: productSnap.data != null
                ? (productSnap.data.length + 1)
                : 0, //increment list size to view checkout row
            itemBuilder: (context, index) {
              Product product;
              if (index < productSnap.data.length) {
                //checking if last row,because i had increment +1 in list size
                product = productSnap.data[index];
                total = total + double.parse(product.cost);
                //using product.cost for cartlist,its the final cost
                //with price*quantity
              }
              if (index == productSnap.data.length) {
                //checking last
                return CartEndCheckoutRow(
                  leftTxt: 'Rs.${total.toStringAsFixed(2)}',
                  rightTxt: 'CHECKOUT',
                );
              }
              //dropdown slected will response from product.getProductSize
              return ProductListItem(
                product: product,
                pos: index,
                products: productSnap.data,
                isCart: true,
                triggerOnUpdateQtyCallback: () {
                  setState(() {
                    //for refreshing
                  });
                },
              );
            },
          ),
        );
      },
      future: productsVm,
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
