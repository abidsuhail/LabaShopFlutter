import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/wishlist_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:provider/provider.dart';

class WishListFragment extends StatefulWidget {
  static const ID = 'WishListFragment';
  final Category category;
  WishListFragment({this.category});
  @override
  _WishListFragmentState createState() => _WishListFragmentState();
}

class _WishListFragmentState extends State<WishListFragment>
    implements ScreenCallback {
  WishListFragmentVm vm;
  @override
  void initState() {
    super.initState();
    vm = Provider.of<WishListFragmentVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /*   Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(CartListFragment.ID); */
        Provider.of<FragmentNotifier>(context, listen: false).navigatedBack();

        return false;
      },
      child: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            UIHelper.getHtmlUnscapeString('WishList'),
            style: TextStyle(
              fontSize: 21,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        FutureBuilder(
          future: vm.getWishList(listener: this),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Product> products = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (products == null || products.length == 0) {
              return Center(
                child: Text('No Wishlist'),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductListItem(
                    product: products[index],
                    products: products,
                    pos: index,
                    isProductDetailsScreen: false,
                    isWishList: true,
                    triggerOnUpdateQtyCallback: () {
                      setState(() {
                        //refreshing on addToCart
                      });
                    },
                    isCart: false,
                  );
                },
                itemCount: products == null ? 0 : products.length);
          },
        ),
      ]),
    );
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }
}
