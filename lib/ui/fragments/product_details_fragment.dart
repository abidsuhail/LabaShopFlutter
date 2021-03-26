import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/ui/adapters/products_by_cat_paging_list_adapter.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/product_details_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/product_qty_btn_counter.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';

class ProductDetailsFragment extends StatefulWidget {
  static const ID = 'ProductDetailsFragment';
  final Product product;
  ProductDetailsFragment({this.product});
  @override
  _ProductDetailsFragmentState createState() => _ProductDetailsFragmentState();
}

class _ProductDetailsFragmentState extends State<ProductDetailsFragment>
    implements ScreenCallback {
  ProductDetailsFragmentVm vm;
  Product product;
  String selectedImg;
  ProductsByCatPagingListAdapter adapter;
  int qty;
  bool addToCartVisibility = true,
      qtyCounterVisibility = false,
      sizeVisibility = true;
  @override
  void initState() {
    super.initState();
    vm = Provider.of<ProductDetailsFragmentVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    product = widget.product;
    qty = product.qty;
    if (adapter == null) {
      adapter = ProductsByCatPagingListAdapter(
        categoryId: product.categoryId,
        subCatId: product.subCategoryId,
        category: null,
        isProductDetailsScreen: true,
      );
    }
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(HomeContentFragment.ID);
        return false;
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: ListView(children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              UIHelper.getHtmlUnscapeString(product.productName),
              style: TextStyle(fontSize: 22, color: AppColors.colorPrimaryObj),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              UIHelper.getHtmlUnscapeString(
                  'Rs.${product.price.isNotEmpty ? product.price[0].cost : 0}'),
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.start,
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey,
          ),
          Container(
            height: 250,
            child: Center(
              /* child: Image.network(
                    selectedImg == null ? product.productImg[0] : selectedImg) */
              child: PinchZoom(
                image: CachedNetworkImage(
                  imageUrl:
                      selectedImg == null ? product.productImg[0] : selectedImg,
                ),
                zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                resetDuration: const Duration(milliseconds: 100),
                maxScale: 2.5,
                onZoomStart: () {
                  print('Start zooming');
                },
                onZoomEnd: () {
                  print('Stop zooming');
                },
              ),
              /* child: CachedNetworkImage(
                imageUrl:
                    selectedImg == null ? product.productImg[0] : selectedImg,
              ), */
            ),
          ),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount:
                  product.productImg.isNotEmpty ? product.productImg.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImg = product.productImg[index];
                      adapter.pagingController.refresh();
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child:
                        CachedNetworkImage(imageUrl: product.productImg[index]),
                  ),
                );
              },
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              ' ${product.productShortDesc}',
            ),
          ),
          Row(
            children: [
              Expanded(
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      color: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      onPressed: () {},
                      child: Text(
                        'ADD TO WISHLIST',
                        style: TextStyle(color: Colors.white),
                      ))),
              Visibility(
                visible: product.qty == 0,
                child: Expanded(
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        color: AppColors.colorPrimaryObj,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        onPressed: () {
                          setState(() {
                            qty = qty + 1;
                            product.qty = qty;
                          });
                          vm
                              .addToCart(product, false.toString(),
                                  listener: this, context: context)
                              .then((value) => UIHelper.showShortToast(value));
                          //vm.addToCart(product, qty, single, dropDownValue, products, pos, listener: listener)
                        },
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
              Visibility(
                visible: product.qty > 0,
                child: Expanded(
                  child: ProductQtyButtonCounter(
                    visibility: product.qty > 0,
                    count: product.qty.toString(),
                    onMinusPressed: () {
                      onMinusClicked(product, context, false);
                    },
                    onPlusPressed: () {
                      onPlusClicked(product, context, false);
                    },
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Related Products',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          adapter
          //AddressListAdapter(vm: vm),
        ]),
      ),
    );
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
      product.qty = qty;
    });
    vm
        .addToCart(product, single.toString(), listener: this, context: context)
        .then((value) => UIHelper.showShortToast(value));
    //addToCart(product, qty, context, single, widget.pos);
  }

  void onPlusClicked(Product product, BuildContext context, bool single) {
    setState(() {
      qty = qty + 1;
      product.qty = qty;
    });
    vm
        .addToCart(product, single.toString(), listener: this, context: context)
        .then((value) => UIHelper.showShortToast(value));
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
