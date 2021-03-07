import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:labashop_flutter_app/colors/colors.dart';
import 'package:labashop_flutter_app/listener/screen_callback.dart';
import 'package:labashop_flutter_app/model/banner.dart' as AppBanners;
import 'package:labashop_flutter_app/model/category.dart';
import 'package:labashop_flutter_app/model/product.dart';
import 'package:labashop_flutter_app/ui/adapters/category_list_adapter.dart';
import 'package:labashop_flutter_app/ui/adapters/products_paging_list_adapter.dart';
import 'package:labashop_flutter_app/utils/uihelper.dart';
import 'package:labashop_flutter_app/viewmodels/home_screen_vm.dart';
import 'package:labashop_flutter_app/widgets/list_items/product_category_list_item.dart';
import 'package:labashop_flutter_app/widgets/search_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'banners_images_slider.dart';
import 'laba_appbars.dart';

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
          flexibleSpace: LabaSearchAppBar(),
          elevation: 0,
          toolbarHeight: 65,
        ),
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(7),
              height: 200,
              color: Color(AppColors.colorPrimary),
              child:BannersImageSlider(bannersList: bannersList, dummyBanner: dummyBanner),
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
            CategoryListAdapter(categoryList: categoryList),
             Flexible(child: ProductsPagingListAdapter())
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
    dummyBanner  = [];
    dummyBanner.add(AppBanners.Banner(bannerId:0,bannerImg:"www.google.com",bannerLink:""));

    List<AppBanners.Banner> bannersList = await HomeScreenVm.getInstance().getBanners(listener: this);
    setState(() {
      this.bannersList = bannersList;
    });


    List<Category> categoryList = await HomeScreenVm.getInstance().getCategories(listener: this);
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
  void onError(String message) {
    UIHelper.showShortToast(message);
  }


}









