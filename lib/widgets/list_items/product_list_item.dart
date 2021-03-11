import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:provider/provider.dart';

import '../product_qty_btn_counter.dart';
import '../product_widgets.dart';

class ProductListItem extends StatefulWidget{
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

class _ProductListItemState extends State<ProductListItem>  implements ScreenCallback {
  int qty = 0;
  bool addToCartVisibility=true, qtyCounterVisibility=false,sizeVisibility=true;
  Price dropDownValue;
  CartModel cartModel;
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    cartModel = widget.cartModel;
    products = widget.products;
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
                ProductMultiplePriceDropDown(product:product,dropDownValue:dropDownValue),
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
                        visibility: qtyCounterVisibility,
                        count: qty.toString(),
                        onMinusPressed: () =>onMinusClicked(product,context),
                        onPlusPressed: () => onPlusClicked(product,context),
                      ),
                      AddToCartButton(
                        visibility: addToCartVisibility,
                        onPressed: () {
                          //TODO add to cart
                          setState(() {
                            addToCartVisibility = false;
                            qtyCounterVisibility = true;
                          });
                          addToCart(product,qty,context);

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

  void addToCart(Product product, int qty, BuildContext context) async{
    //TODO ADD THESE LOGICS TO HOMESCREEN VIEW MODEL
    cartModel = await AppSharedPrefs.getCartModel();
    //int qty=Integer.parseInt(txtQty.getText().toString()); //quantity
    qty=qty+1;
    double p=product.price.isNotEmpty ? double.parse(product.price[0].cost) : 0.0;
    double c=qty*p;
    product.qty=qty;
    product.cost = c.toString();
    String size=product.price.length>1 ? dropDownValue :product.price[0].size;

    product.qty=qty;
    product.size=size;

    /*if (updateAdapter)
      productListAdapter.notifyDataSetChanged();
    String sessionId = ((UserRepositoryImpl) uRepository).getAuthToken();
    if (sessionId == null || sessionId.equalsIgnoreCase("")) {
      sessionId = MainApp.getInstance().getAndroidId();
    }*/

    //TODO CHANGE SESSION ID TO == AUTHTOKEN

    String sid = "";
    String pid = "";
    String qtyA = "";
    String cost = "";
    String sizeStr = "";
    List<String> pidArr = cartModel.getPidArray();
    List<String> qtyArr = cartModel.getQtyArray();
    List<String> costArr = cartModel.getCostArray();
    List<String> sizeArr = cartModel.getSizeArray();
    int itemCount = 0;
    for (int j = 0; j < pidArr.length; j++) {
      if (!isCartProductIdExistInList(pidArr[j])) {
        sid = sid + "asjdyas89sdasd7a98sd8uauios" + ",";
        pid = pid + pidArr[j] + ",";
        qtyA = qtyA + qtyArr[j] + ",";
        cost = cost + costArr[j] + ",";
        sizeStr = sizeStr + sizeArr[j] + ",";
        itemCount++;
      }
    }
    for (int i = 0; i < products.length; i++) {
      Product p = products[i];
      if (p!=null)
        if (p.qty > 0) {
          sid = sid + 'asjdyas89sdasd7a98sd8uauios' + ",";
          pid = pid + p.productId.toString() + ",";
          qtyA = qtyA + p.qty.toString() + ",";
          sizeStr = sizeStr + p.size + ",";
          cost = cost + double.parse(p.cost.
          replaceAll("SAR", "").
          replaceAll(" ", "")).toString() + ",";
          itemCount++;
        }
    }
      Provider.of<HomeScreenVm>(context,listen: false).setCartCount(itemCount.toString());
      print('itemcount ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt $itemCount');
    if (sid.length > 0)
      sid = sid.substring(0, sid.length - 1);
    if (pid.length > 0)
      pid = pid.substring(0, pid.length - 1);
    if (qtyA.length > 0)
      qtyA = qtyA.substring(0, qtyA.length - 1);
    if (cost.length > 0)
      cost = cost.substring(0, cost.length - 1);
    if (sizeStr.length > 0)
      sizeStr = sizeStr.substring(0, sizeStr.length - 1);
    cartModel.pid=(pid);
    cartModel.qty=(qtyA);
    cartModel.sid=(sid);
    cartModel.cost=(cost);
    cartModel.size=(sizeStr);
    //AppSharedPref.getInstance().putPref(AppSharedPref.CART_JSON, new Gson().toJson(cartModel));
    AppSharedPrefs.saveCartJSON(jsonEncode(cartModel));
    if (pid=="")
      sid = 'sessionId';
   // mPresenter.addToCart(sid, pid, qtyA, cost, sizeStr, "false");
    String msg = await Provider.of<HomeScreenVm>(context,listen: false).addToCart(sid, pid, qtyA, cost, size, false.toString(), listener: this);
    UIHelper.showShortToast(msg);
  }


  bool isCartProductIdExistInList(String productId) {
    bool flag = false;
    if (productId=="") {
      flag = true;
    } else {
      for (int i = 0; i < products.length; i++) {
        if (products[i].productId.toString() == productId) {
          flag = true;
          break;
        }
      }
    }
    return flag;
  }
  void onMinusClicked(Product product, BuildContext context) {
    setState(() {
      qty--;
      if(qty<=0)
      {
        qty = 0;
        addToCartVisibility = true;
        qtyCounterVisibility = false;
      }
      else
      {
        addToCartVisibility = false;
        qtyCounterVisibility = true;
      }
      addToCart(product,qty,context);
    });
  }


  @override
  void onError(String message) {

  }

  void onPlusClicked(Product product, BuildContext context) {
    setState(() {
      qty++;
    });
    addToCart(product, qty,context);
  }

  @override
  void showProgress() {

  }

  @override
  void hideProgress() {

  }
}

