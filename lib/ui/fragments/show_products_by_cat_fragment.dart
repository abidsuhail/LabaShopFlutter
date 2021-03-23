import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/products_by_cat_paging_list_adapter.dart';

class ShowProductsByCatFragment extends StatefulWidget {
  static const ID = 'ShowProductsByCatFragment';
  final Category category;
  ShowProductsByCatFragment({this.category});
  @override
  _ShowProductsByCatFragmentState createState() =>
      _ShowProductsByCatFragmentState();
}

class _ShowProductsByCatFragmentState extends State<ShowProductsByCatFragment>
    implements ScreenCallback {
  @override
  Widget build(BuildContext context) {
    return ProductsByCatPagingListAdapter(
      category: widget.category,
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
