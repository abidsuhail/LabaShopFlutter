import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/products_by_cat_paging_list_adapter.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:provider/provider.dart';

import 'home_content_fragment.dart';

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
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(HomeContentFragment.ID);
        return false;
      },
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              UIHelper.getHtmlUnscapeString(widget.category.categoryName),
              style: TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemCount: widget.category.subCat.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(UIHelper.getHtmlUnscapeString(
                        widget.category.subCat[index].subCategoryName)),
                  ),
                ));
              },
            ),
          ),
          ProductsByCatPagingListAdapter(
            category: widget.category,
          ),
        ],
      ),
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
