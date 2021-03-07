import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:labashop_flutter_app/model/banner.dart' as AppBanners;

class BannersImageSlider extends StatelessWidget {
  const BannersImageSlider({
    @required this.bannersList,
    @required this.dummyBanner,
  });

  final List<AppBanners.Banner> bannersList;
  final List<AppBanners.Banner> dummyBanner;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height:250,autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        viewportFraction: 1.0,
      ),
      items: bannersList==null?dummyBanner.map((e){
        return Builder(
          builder: (BuildContext context) {
            return Image.network(
              '${e.bannerImg}',fit: BoxFit.fill,height: 200,);
          },
        );
      }).toList():bannersList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.network(
              '${i.bannerImg}',fit: BoxFit.fill,height: 200,);
          },
        );
      }).toList(),
    );
  }
}