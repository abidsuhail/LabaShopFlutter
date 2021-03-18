import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:provider/provider.dart';

import '../product_qty_btn_counter.dart';
import '../product_widgets.dart';

class ProductListItem extends StatefulWidget {
  const ProductListItem({
    @required this.product,
    @required this.cartModel,
    @required this.products,
  });

  final Product product;
  final CartModel cartModel;
  final List<Product> products;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem>
    implements ScreenCallback {
  int qty;
  bool addToCartVisibility = true,
      qtyCounterVisibility = false,
      sizeVisibility = true;
  Price selecteddropDownPrice;
  CartModel cartModel;
  List<Product> products;
  Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    cartModel = widget.cartModel;
    products = widget.products;
    qty = product.qty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CachedNetworkImage(
              height: 120,
              width: 120,
              imageUrl: "${product.productImg[0]}",
              /*        placeholder: (context, url) => Padding(
                  padding: EdgeInsets.all(60),
                  child: CircularProgressIndicator()),*/
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitle(product: product),
                ProductSize(product: product),
                ProductMultiplePriceDropDown(
                    product: product, dropDownValue: selecteddropDownPrice),
                //ProductAddToCartRow
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Product price
                      Text(
                          'Rs.${product.price.isNotEmpty ? product.price[0].cost : 'N/A'}',
                          style: TextStyle(
                              //TODO change N/A to number later
                              fontWeight: FontWeight.bold)),
                      ProductQtyButtonCounter(
                        visibility: qtyCounterVisibility || product.qty > 0,
                        count: qty.toString(),
                        onMinusPressed: () =>
                            onMinusClicked(product, context, true),
                        onPlusPressed: () =>
                            onPlusClicked(product, context, true),
                      ),
                      AddToCartButton(
                        visibility: addToCartVisibility && product.qty == 0,
                        onPressed: () {
                          setState(() {
                            addToCartVisibility = false;
                            qtyCounterVisibility = true;
                            qty = qty + 1;
                          });
                          addToCart(product, qty, context, true);
                        },
                      )
                    ],
                  ),
                ),
                Container(
                    color: Colors.black,
                    height: 1,
                    child: SizedBox(width: double.infinity))
              ],
            ),
          )
        ],
      ),
    );
  }

  void addToCart(
      Product product, int qty, BuildContext context, bool single) async {
    String msg = await Provider.of<HomeScreenVm>(context, listen: false)
        .addToCart(
            product, qty, single.toString(), selecteddropDownPrice, products,
            listener: this);
    UIHelper.showShortToast(msg);
  }

  void onMinusClicked(Product product, BuildContext context, bool single) {
    setState(() {
      qty = qty - 1;
      if (qty <= 0) {
        // qty = 0;
        addToCartVisibility = true;
        qtyCounterVisibility = false;
      } else {
        addToCartVisibility = false;
        qtyCounterVisibility = true;
      }
      //product.qty = qty;
      addToCart(product, qty, context, single);
    });
  }

  @override
  void onError(String message) {}

  void onPlusClicked(Product product, BuildContext context, bool single) {
    setState(() {
      qty = qty + 1;
      addToCart(product, qty, context, single);
    });
  }

  @override
  void showProgress() {}

  @override
  void hideProgress() {}
}
