import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/ui/fragments/product_details_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/products_by_category_fragment_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_list_item.dart';
import 'package:provider/provider.dart';

class ProductsByCatPagingListAdapter extends StatefulWidget {
  final Category category;
  int subCatId, categoryId;
  bool isProductDetailsScreen;
  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  ProductsByCatPagingListAdapter(
      {@required this.category,
      @required this.categoryId,
      @required this.subCatId,
      @required this.isProductDetailsScreen});
  @override
  _ProductsByCatPagingListAdapterState createState() =>
      _ProductsByCatPagingListAdapterState();
}

class _ProductsByCatPagingListAdapterState
    extends State<ProductsByCatPagingListAdapter> implements ScreenCallback {
  static const _pageSize = 6;
  static const int _progress_delay = 1000;
  List<Product> allProducts = [];

  ShowProductsByCatFragmentVm vm;
  bool firstTime = true;
  CartModel cartModel;
  List<Product> products;

  @override
  void onError(String message) {
    UIHelper.showShortToast(message);
  }

  @override
  void initState() {
    super.initState();
    vm = Provider.of<ShowProductsByCatFragmentVm>(context, listen: false);
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (widget.category != null) {
        products = await vm.getProductsByCat(
          catId: widget.category.categoryId.toString(),
          subCatId: widget.subCatId == null
              ? widget.category.subCat[0].subCategoryId.toString()
              : widget.subCatId.toString(),
          pageSize: _pageSize.toString(),
          pageNo: pageKey.toString(),
          listener: this,
        );
      } else {
        products = await vm.getProductsByCat(
          catId: widget.categoryId.toString(),
          subCatId: widget.subCatId.toString(),
          pageSize: _pageSize.toString(),
          pageNo: pageKey.toString(),
          listener: this,
        );
      }
      allProducts.addAll(products);
      final isLastPage = (products != null)
          ? (products.length < _pageSize || products.length == 0)
          : true; //check for null
      if (isLastPage) {
        Future.delayed(const Duration(milliseconds: _progress_delay), () {
          widget.pagingController.appendLastPage(products);
        });
      } else {
        final nextPageKey = pageKey + 1;
        Future.delayed(const Duration(milliseconds: _progress_delay), () {
          widget.pagingController.appendPage(products, nextPageKey);
        });
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, Product>(
        pagingController: widget.pagingController,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Provider.of<FragmentNotifier>(context, listen: false).setFargment(
                  ProductDetailsFragment.ID,
                  object: allProducts[index]);
            },
            child: ProductListItem(
              product: item,
              products: allProducts,
              pos: index,
              isCart: false,
              isProductDetailsScreen: widget.isProductDetailsScreen,
              triggerOnUpdateQtyCallback: () {},
            ),
          ),
        ),
      );

  @override
  void dispose() {
    if (widget.pagingController != null) {
      widget.pagingController.dispose();
      firstTime = true;
    }
    super.dispose();
  }

  @override
  void showProgress() {}

  @override
  void hideProgress() {}
}
