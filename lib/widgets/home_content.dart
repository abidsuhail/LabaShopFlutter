import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/banner.dart' as AppBanners;
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_category_list_item.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'banners_images_slider.dart';

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
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              alignment: AlignmentDirectional.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: SearchTextField()),
            centerTitle: true,
          ),
          elevation: 0,
          toolbarHeight: 60,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              height: 200,
              color: Color(AppColors.colorPrimary),
              child: Column(
                children: [
                 /* SearchTextField(),*/
                  SizedBox(
                    height: 8,
                  ),
                  BannersImageSlider(bannersList: bannersList, dummyBanner: dummyBanner)
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
                  return ProductCategoryListItem(
                    categoryImage: categoryList[index].categoryImg,
                    categoryName:categoryList[index].categoryName ,);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Category> categoryList;
  List<Product> productsList;
  List<AppBanners.Banner> bannersList,dummyBanner;

  bool progress = false;

  void getProductsOnHome() async {
    dummyBanner  = new List<AppBanners.Banner>();
    dummyBanner.add(AppBanners.Banner(bannerId:0,bannerImg:"",bannerLink:""));
    List<Product> productList = await HomeScreenVm.getInstance().getProductsOnHome(listener: this);
    List<Category> categoryList = await HomeScreenVm.getInstance().getCategories(listener: this);
    List<AppBanners.Banner> bannersList = await HomeScreenVm.getInstance().getBanners(listener: this);

    setState(() {
      this.productsList = productList;
      this.categoryList = categoryList;
      this.bannersList = bannersList;
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


