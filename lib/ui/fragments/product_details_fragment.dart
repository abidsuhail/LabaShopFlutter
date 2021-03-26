import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/ui/adapters/products_by_cat_paging_list_adapter.dart';
import 'package:labashop_flutter_app/ui/fragments/home_content_fragment.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/notifiers/fragment_change_notifier.dart';
import 'package:labashop_flutter_app/viewmodels/product_details_fragment_vm.dart';
import 'package:provider/provider.dart';

class ProductDetailsFragment extends StatefulWidget {
  static const ID = 'ProductDetailsFragment';
  final Product product;
  ProductDetailsFragment({this.product});
  @override
  _ProductDetailsFragmentState createState() => _ProductDetailsFragmentState();
}

class _ProductDetailsFragmentState extends State<ProductDetailsFragment> {
  ProductDetailsFragmentVm vm;
  Product product;
  @override
  void initState() {
    super.initState();
    vm = Provider.of<ProductDetailsFragmentVm>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    product = widget.product;
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
              height: 200,
              child: Center(child: Image.network(product.productImg[0]))),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount:
                  product.productImg.isNotEmpty ? product.productImg.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  child: Image.network(product.productImg[index]),
                );
              },
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Description ${product.productShortDesc}',
              style: TextStyle(fontWeight: FontWeight.bold),
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
              Expanded(
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      color: AppColors.colorPrimaryObj,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      onPressed: () {},
                      child: Text(
                        'ADD TO CART',
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Related Products',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ProductsByCatPagingListAdapter(
            categoryId: product.categoryId,
            subCatId: product.subCategoryId,
            category: null,
          )
          //AddressListAdapter(vm: vm),
        ]),
      ),
    );
  }
}
