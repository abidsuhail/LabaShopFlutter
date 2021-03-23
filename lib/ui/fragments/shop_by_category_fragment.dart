import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/ui/adapters/category_list_adapter.dart';
import 'package:labashop_flutter_app/viewmodels/shop_by_category_fragment_vm.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ShopByCategoryFragment extends StatefulWidget {
  @override
  _ShopByCategoryFragmentState createState() => _ShopByCategoryFragmentState();
}

class _ShopByCategoryFragmentState extends State<ShopByCategoryFragment>
    implements ScreenCallback {
  ShopByCategoryFragmentVm vm;
  bool _progress = true;
  @override
  Widget build(BuildContext context) {
    vm = Provider.of<ShopByCategoryFragmentVm>(context);
    return FutureBuilder<List<Category>>(
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
        return GestureDetector(
            onTap: () {
              //TODO:open category product
            },
            child: ListView(
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
                CategoryListAdapter(categoryList: productSnap.data),
              ],
            ));
      },
      future: vm.getCategories(listener: this),
    );
  }

  @override
  void hideProgress() {}

  @override
  void onError(String message) {}

  @override
  void showProgress() {}
}
