import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/category_list_adapter.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/ui/fragments/show_products_by_cat_fragment.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/show_categories_fragment_vm.dart';
import 'package:provider/provider.dart';

class ShowCategoriesFragment extends StatefulWidget {
  static const ID = 'ShowCategoriesFragment';

  @override
  _ShowCategoriesFragmentState createState() => _ShowCategoriesFragmentState();
}

class _ShowCategoriesFragmentState extends State<ShowCategoriesFragment>
    implements ScreenCallback {
  ShowCategoriesFragmentVm vm;
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<ShowCategoriesFragmentVm>(context);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FragmentNotifier>(context, listen: false)
            .setFargment(HomeContentFragment.ID);
        return false;
      },
      child: FutureBuilder<List<Category>>(
        initialData: [],
        builder: (context, productSnap) {
          if (!productSnap.hasData || productSnap.data.isEmpty) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Shop By Category',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              CategoryListAdapter(
                categoryList: productSnap.data,
                onCatClick: (clickedCategory) {
                  Provider.of<FragmentNotifier>(context, listen: false)
                      .setFargment(ShowProductsByCatFragment.ID,
                          object: clickedCategory);
                },
              ),
            ],
          );
        },
        future: vm.getCategories(listener: this),
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
