import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';

class HomeContent extends StatelessWidget implements ScreenCallback {

  @override
  Widget build(BuildContext context) {

    getProductsOnHome();
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              height: 240,
              color: Color(AppColors.colorPrimary),
              child: Column(
                children: [
                  SearchTextField(),
                  SizedBox(
                    height: 8,
                  ),
                  Image.network(
                      'http://thelabashopping.com////admin//images//banners//3//b21.jpg'),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Text(
              'Shop By Category',
              style: TextStyle(fontSize: 20, color: Colors.grey,),
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
    );
  }

  @override
  void onError(String message) {

  }

  @override
  void hideProgress() {

  }

  @override
  void showProgress() {

  }

  void getProductsOnHome() async{
    List<Product> productList = await HomeScreenVm.getInstance().getProductsOnHome(listener: this);
    List<Category> categoryList = await HomeScreenVm.getInstance().getCategories(listener: this);

/*    for(Product product in productList.products)
      {
        print(product.productName);
      }*/
    for(Category product in categoryList)
    {
      print(product.categoryName);
    }

  }
}
