import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/select_delivery_option_fragment.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/viewmodels/cart_list_fragment_vm.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/widgets/cart_list_end_checkout_row.dart';
import 'package:provider/provider.dart';

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
          return Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your Cart is Empty',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      color: AppColors.colorPrimaryObj,
                      onPressed: () {
                        Provider.of<FragmentNotifier>(context, listen: false)
                            .setFargment(HomeContentFragment.ID);
                      },
                      child: Text('Continue Shopping',
                          style: TextStyle(fontSize: 20, color: Colors.white)))
                ]),
          );
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
                print('-----------------$total----------------------------');
                //using product.cost for cartlist,its the final cost
                //with price*quantity
              }
              if (index == productSnap.data.length) {
                //checking last
                AppSharedPrefs.saveTotalPayableAmt(
                    total.toStringAsFixed(2)); //saving payable amt to local
                return GestureDetector(
                  onTap: () {
                    Provider.of<FragmentNotifier>(context, listen: false)
                        .setFargment(SelectDeliveryOptionFragment.ID);
                  },
                  child: CartEndCheckoutRow(
                    leftTxt: 'Rs.${total.toStringAsFixed(2)}',
                    rightTxt: 'CHECKOUT',
                  ),
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
