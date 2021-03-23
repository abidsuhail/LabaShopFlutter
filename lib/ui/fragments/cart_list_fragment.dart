import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_vm.dart';
import 'package:labashop_flutter_app/widgets/cart_list_end_checkout_row.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:provider/provider.dart';

class CartListFragment extends StatefulWidget {
  @override
  _CartListFragmentState createState() => _CartListFragmentState();
}

class _CartListFragmentState extends State<CartListFragment>
    implements ScreenCallback {
  CartListFragmentVm vm;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CartListFragmentVm>(context);
    total = 0;
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
        FutureBuilder<List<Product>>(
          builder: (context, productSnap) {
            if (productSnap.connectionState == ConnectionState.none &&
                productSnap.hasData == null) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container();
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
                    total = total +
                        double.parse(product
                            .cost); //TODO:add this when we get list,not here
                  }
                  if (index == productSnap.data.length) {
                    //checking last
                    return CartEndCheckoutRow(
                      leftTxt: 'Rs.${total.toString()}',
                      rightTxt: 'CHECKOUT',
                    );
                  }
                  return ProductListItem(
                    product: product,
                    pos: index,
                    products: productSnap.data,
                    isCart: true,
                  );
                },
              ),
            );
          },
          future: vm.getCartList(listener: this),
        ),
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
