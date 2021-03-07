import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';

class ProductsPagingListAdapter extends StatefulWidget {
  @override
  _ProductsPagingListAdapterState createState() => _ProductsPagingListAdapterState();
}

class _ProductsPagingListAdapterState extends State<ProductsPagingListAdapter> implements ScreenCallback{
  static const _pageSize = 6;
  static const int _progress_delay = 1500;
  final PagingController<int, Product> _pagingController =
  PagingController(firstPageKey: 1);


  @override
  void onError(String message) {
    UIHelper.showShortToast(message);
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Product> newItems = await HomeScreenVm.getInstance().getProductsOnHome(listener: this,pageNo: pageKey,pageSize:_pageSize);
      final isLastPage = (newItems != null) ? (newItems.length < _pageSize || newItems.length == 0) : true; //check for null
        if (isLastPage) {
          Future.delayed(const Duration(milliseconds: _progress_delay), () {
            _pagingController.appendLastPage(newItems);
          });
        } else {
          final nextPageKey = pageKey + 1;
          Future.delayed(const Duration(milliseconds: _progress_delay), () {
            _pagingController.appendPage(newItems, nextPageKey);
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
      itemBuilder: (context, item, index) =>
          ProductListItem(
        product: item,
      ),
    ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void showProgress() {

  }

  @override
  void hideProgress() {

  }
}