import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> implements ScreenCallback {
  @override
  void initState() {
    super.initState();
    getProductsOnHome();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      child: Container(
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
              SizedBox(
                height: 5,
              ),
              Text(
                'Shop By Category',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                      categoryList == null ? 0 : categoryList.length, (index) {
                    return Card(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                '${categoryList[index].categoryImg}',
                                fit: BoxFit.fill,
                                height: 100,
                                width: 120,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Item ${categoryList[index].categoryName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            ]),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Category> categoryList;
  bool progress = false;

  void getProductsOnHome() async {
    //List<Product> productList = await HomeScreenVm.getInstance().getProductsOnHome(listener: this);
    List<Category> categoryList =
        await HomeScreenVm.getInstance().getCategories(listener: this);
    setState(() {
      this.categoryList = categoryList;
    });
  }

  @override
  void hideProgress() {
    setState(() {
      progress = false;
    });
  }

  @override
  void showProgress() {
    setState(() {
      progress = true;
    });
  }

  @override
  void onError(String message) {}
}
