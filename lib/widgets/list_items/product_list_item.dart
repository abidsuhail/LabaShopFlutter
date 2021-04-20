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
    @required this.products,
    @required this.pos,
    @required this.isCart,
    @required this.triggerOnUpdateQtyCallback,
    @required this.isProductDetailsScreen,
    this.isWishList,
  });

  final Product product;
  final List<Product> products;
  final int pos;
  final bool isCart, isWishList;
  final bool isProductDetailsScreen;
  final Function triggerOnUpdateQtyCallback;

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
  String updatedCost;
  double total = 0;
  @override
  void initState() {
    super.initState();
    products = widget.products;
    product = widget.product;
    qty = product.qty;
    if (product.price.isNotEmpty) {
      product.size = product.price[0].size;
      selecteddropDownPrice =
          product.price[0]; //default size on add to cart click
      if (widget.isCart) {
        updatedCost =
            (double.parse(product.price[0].cost) * qty).toStringAsFixed(2);
      } else {
        updatedCost = product.price[0].cost;
      }
    } else {
      updatedCost = '0'; //TODO CHANGE LATER
    }
  }

  Text priceTextWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
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
                    ProductTitle(
                      product: product,
                      productTitle: null,
                    ),
                    ProductSize(
                      product: product,
                      orderDetails: null,
                    ),
                    ProductMultiplePriceDropDown(
                      product: product,
                      dropDownValue: selecteddropDownPrice,
                      onSizeSelectCallback: (updatedDropDownPrice) {
                        setState(() {
                          selecteddropDownPrice = updatedDropDownPrice;
                        });
                      },
                    ),
                    //ProductAddToCartRow
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Product price
                          Text(
                              'Rs.${product.price.isNotEmpty ? updatedCost : 'N/A'}',
                              style: TextStyle(
                                  //TODO change N/A to number later
                                  //TODO FOR CART LIST,get property cart product size
                                  fontWeight: FontWeight.bold)),

                          (widget.isProductDetailsScreen == null ||
                                  !widget.isProductDetailsScreen)
                              ? AddToCartButton(
                                  visibility:
                                      (addToCartVisibility && product.qty == 0),
                                  onPressed: () {
                                    if (widget.isWishList == null ||
                                        !widget.isWishList) {
                                      setState(() {
                                        addToCartVisibility = false;
                                        qtyCounterVisibility = true;
                                        qty = qty + 1;
                                        updateCostLabel(qty);
                                      });
                                    } else {
                                      //is wish list
                                      qty = qty + 1;
                                    }
                                    addToCart(product, qty, context, true,
                                        widget.pos);
                                  },
                                )
                              : SizedBox(height: 0),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (qtyCounterVisibility || product.qty > 0),
                      child: Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            (widget.isProductDetailsScreen == null ||
                                    !widget.isProductDetailsScreen)
                                ? ProductQtyButtonCounter(
                                    visibility: (qtyCounterVisibility ||
                                        product.qty > 0),
                                    count: qty.toString(),
                                    onMinusPressed: () =>
                                        onMinusClicked(product, context, true),
                                    onPlusPressed: () =>
                                        onPlusClicked(product, context, true),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        /* Visibility(
          visible: widget != null ? !widget.isCart : false,
          child: Container(
              color: Colors.black,
              height: 1,
              child: SizedBox(width: double.infinity)),
        ), */
        Visibility(
          visible: widget != null ? !widget.isCart : false,
          child: Divider(
            height: 2,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  void addToCart(Product product, int qty, BuildContext context, bool single,
      int pos) async {
    // UIHelper.showShortToast(product.productName);
    String msg = await Provider.of<HomeScreenVm>(context, listen: false)
        .addToCart(product, qty, single.toString(), selecteddropDownPrice,
            products, pos,
            listener: this);
    UIHelper.showShortToast(msg);
    if (widget.isWishList != null && widget.isWishList) {
      widget.triggerOnUpdateQtyCallback();
    }
  }

  void onMinusClicked(Product product, BuildContext context, bool single) {
    int newQty;

    setState(() {
      qty = qty - 1;
      if (qty <= 0) {
        qty = 0;
        newQty = 1;
        addToCartVisibility = true;
        qtyCounterVisibility = false;
      } else {
        newQty = qty;
        addToCartVisibility = false;
        qtyCounterVisibility = true;
      }
      updateCostLabel(newQty);
      //product.qty = qty;
    });
    addToCart(product, qty, context, single, widget.pos);
  }

  void onPlusClicked(Product product, BuildContext context, bool single) {
    setState(() {
      qty = qty + 1;
      updateCostLabel(qty);
    });
    addToCart(product, qty, context, single, widget.pos);
  }

  void updateCostLabel(int newQty) {
    if (product.price.isNotEmpty && widget.isCart) {
      updatedCost =
          (double.parse(product.price[0].cost) * int.parse(newQty.toString()))
              .toStringAsFixed(2);
      widget.triggerOnUpdateQtyCallback();
    }
  }

  @override
  void onError(String message) {}

  @override
  void showProgress() {}

  @override
  void hideProgress() {}
}
