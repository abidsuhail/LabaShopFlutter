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
            GridView.count(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                  categoryList == null ? 0 : categoryList.length, (index) {
                return ProductCategoryListItem(
                  categoryImage: categoryList[index].categoryImg,
                  categoryName:categoryList[index].categoryName ,);
              }),
            ),
          /*CharacterListView()*/
      /*ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: productsList==null?0:productsList.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductListItem(product: productsList[index]);
          }
      )*/

      CharacterListView()
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
    dummyBanner.add(AppBanners.Banner(bannerId:0,bannerImg:"www.google.com",bannerLink:""));
   //List<Product> productList = await HomeScreenVm.getInstance().getProductsOnHome(listener: this,pageNo: 1);
    List<Category> categoryList = await HomeScreenVm.getInstance().getCategories(listener: this);
    List<AppBanners.Banner> bannersList = await HomeScreenVm.getInstance().getBanners(listener: this);

    setState(() {
     //this.productsList = productList;
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

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key key,
    @required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(child: Text('${product.productName}')),
    );
  }
}
class CharacterListView extends StatefulWidget {
  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> implements ScreenCallback{
  static const _pageSize = 10;

  final PagingController<int, Product> _pagingController =
  PagingController(firstPageKey: 1);


  @override
  void onError(String message) {

  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    print(' page key ${pageKey}');
    try {
      List<Product> newItems = await HomeScreenVm.getInstance().getProductsOnHome(listener: this,pageNo: pageKey,pageSize:_pageSize);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
  // package takes care of that. If you want to customize them, use the
  // [PagedChildBuilderDelegate] properties.
  PagedListView<int, Product>(
    shrinkWrap: true,
    physics: ScrollPhysics(),
    pagingController: _pagingController,
    builderDelegate: PagedChildBuilderDelegate<Product>(
      itemBuilder: (context, item, index) => ProductListItem(
        product: item,
      ),
    ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void showProgress() {

  }

  @override
  void hideProgress() {

  }
}




