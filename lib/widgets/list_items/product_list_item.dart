import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';

import '../add_to_cart_btn.dart';
import '../product_qty_btn_counter.dart';

class ProductListItem extends StatefulWidget {
  const ProductListItem({
    @required this.product,
  });

  final Product product;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  int qty = 0;
  bool addToCartVisibility=true, qtyCounterVisibility=false,sizeVisibility=true;
  String dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CachedNetworkImage(
              height: 120,
              width: 120,
              imageUrl: "${widget.product.productImg[0]}",
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
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    constraints: new BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 84),
                    child: Flexible(
                      child: Text(
                        UIHelper.getHtmlUnscapeString(
                            widget.product.productName),
                        softWrap: false,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.product.price.length==1,
                  child: Text(
                    '${widget.product.price.isNotEmpty ? widget.product.price[0].size : 'N/A'} ${widget.product.price.isNotEmpty ? widget.product.price[0].unit : 'N/A'}',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Visibility(
                  visible:widget.product.price.length>1 ,
                  child: DropdownButton(
                      value:widget.product.price[0],
                      onChanged: (newValue) {
                        setState(() {
                            dropDownValue = newValue;
                        });
                        },
                      items:widget.product.price.map<DropdownMenuItem<Price>>((Price value) {
                    return DropdownMenuItem<Price>(
                      value: value,
                      child: Text(value.size),
                    );
                  }).toList()),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Rs.${widget.product.price.isNotEmpty ? widget.product.price[0].cost : 'N/A'}',
                          style: TextStyle(
                              //TODO change N/A to number later
                              fontWeight: FontWeight.bold)),
                      ProductQtyButtonCounter(
                        visibility: qtyCounterVisibility,
                        count: qty.toString(),
                        onMinusPressed: () =>onMinusClicked(),
                        onPlusPressed: () => onPlusClicked(),
                      ),
                      AddToCartButton(
                        visibility: addToCartVisibility,
                        onPressed: () {
                          //TODO add to cart
                          setState(() {
                            addToCartVisibility = false;
                            qtyCounterVisibility = true;
                          });
                          addToCart(widget.product,qty);

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

  void addToCart(Product product, int qty) {
    //int qty=Integer.parseInt(txtQty.getText().toString()); //quantity
/*    qty=qty+1;
    double p=widget.product.price.isNotEmpty ? widget.product.price[0].cost : 0.0;
    double c=qty*p;
    product.qty=qty;
    product.cost = c.toString();
    String size=product.price.length>1 ? spinUnit.getSelectedItem().toString() :txtUnit.getText().toString();

    product.qty=qty;
    product.size=size;

    if (updateAdapter)
      productListAdapter.notifyDataSetChanged();
    String sessionId = ((UserRepositoryImpl) uRepository).getAuthToken();
    if (sessionId == null || sessionId.equalsIgnoreCase("")) {
      sessionId = MainApp.getInstance().getAndroidId();
    }
    String sid = "";
    String pid = "";
    String qtyA = "";
    String cost = "";
    String sizeStr = "";
    String[] pidArr = cartModel.getPidArray();
    String[] qtyArr = cartModel.getQtyArray();
    String[] costArr = cartModel.getCostArray();
    String[] sizeArr = cartModel.getSizeArray();
    int itemCount = 0;
    for (int j = 0; j < pidArr.length; j++) {
      if (!isCartProductIdExistInList(pidArr[j])) {
        sid = sid + sessionId + ",";
        pid = pid + pidArr[j] + ",";
        qtyA = qtyA + qtyArr[j] + ",";
        cost = cost + costArr[j] + ",";
        sizeStr = sizeStr + sizeArr[j] + ",";
        itemCount++;
      }
    }
    for (int i = 0; i < products.size(); i++) {
      Product p = products.get(i);
      if (p!=null)
        if (p.getQty() > 0) {
          sid = sid + sessionId + ",";
          pid = pid + p.getProduct_id() + ",";
          qtyA = qtyA + p.getQty() + ",";
          sizeStr = sizeStr + p.getSize() + ",";
          cost = cost + Float.parseFloat(p.getCost().
          replace("SAR", "").
          replace(" ", "")) + ",";
          itemCount++;
        }
    }
    if (getActivity() != null) {
      HomeActivity home = (HomeActivity) getActivity();
      home.mCartItemCount = itemCount;
      home.setupBadge();
    }
    if (sid.length() > 0)
      sid = sid.substring(0, sid.length() - 1);
    if (pid.length() > 0)
      pid = pid.substring(0, pid.length() - 1);
    if (qtyA.length() > 0)
      qtyA = qtyA.substring(0, qtyA.length() - 1);
    if (cost.length() > 0)
      cost = cost.substring(0, cost.length() - 1);
    if (sizeStr.length() > 0)
      sizeStr = sizeStr.substring(0, sizeStr.length() - 1);
    cartModel.setPid(pid);
    cartModel.setQty(qtyA);
    cartModel.setSid(sid);
    cartModel.setCost(cost);
    cartModel.setSize(sizeStr);
    AppSharedPref.getInstance().putPref(AppSharedPref.CART_JSON, new Gson().toJson(cartModel));
    if (pid.equalsIgnoreCase(""))
      sid = sessionId;
    mPresenter.setRepository(mRepository);
    mPresenter.addToCart(sid, pid, qtyA, cost, sizeStr, "false");*/
  }

  void onMinusClicked() {
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
      addToCart(widget.product,qty);
    });
  }

  void onPlusClicked() {
    setState(() {
      qty++;
    });
    addToCart(widget.product, qty);
  }
}
