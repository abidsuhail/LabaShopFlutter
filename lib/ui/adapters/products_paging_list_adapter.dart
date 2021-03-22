import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/app_shared_prefs.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:provider/provider.dart';

class ProductsPagingListAdapter extends StatefulWidget {
  @override
  _ProductsPagingListAdapterState createState() =>
      _ProductsPagingListAdapterState();
}

class _ProductsPagingListAdapterState extends State<ProductsPagingListAdapter>
    implements ScreenCallback {
  static const _pageSize = 6;
  static const int _progress_delay = 1000;
  List<Product> allProducts = [];
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  HomeScreenVm vm;
  bool firstTime = true;
  CartModel cartModel;
  List<Product> products;

  @override
  void onError(String message) {
    UIHelper.showShortToast(message);
  }

  @override
  void initState() {
    vm = HomeScreenVm.getInstance();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      products = await vm.getProductsOnHome(
          listener: this, pageNo: pageKey, pageSize: _pageSize);
      allProducts.addAll(products);

      if (products.length > 0 && firstTime) {
        firstTime = false;
        Provider.of<HomeScreenVm>(context, listen: false)
            .setCartCount(products[0].itemCount.toString());
      }
      final isLastPage = (products != null)
          ? (products.length < _pageSize || products.length == 0)
          : true; //check for null
      if (isLastPage) {
        Future.delayed(const Duration(milliseconds: _progress_delay), () {
          _pagingController.appendLastPage(products);
        });
      } else {
        final nextPageKey = pageKey + 1;
        Future.delayed(const Duration(milliseconds: _progress_delay), () {
          _pagingController.appendPage(products, nextPageKey);
        });
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.

      PagedListView<int, Product>(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) => ProductListItem(
              product: item,
              cartModel: cartModel,
              products: allProducts,
              pos: index),
        ),
      );

  @override
  void dispose() {
    if (_pagingController != null) {
      _pagingController.dispose();
      firstTime = true;
    }
    super.dispose();
  }

  @override
  void showProgress() {}

  @override
  void hideProgress() {}
}
