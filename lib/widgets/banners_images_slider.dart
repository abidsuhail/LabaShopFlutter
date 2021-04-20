import 'package:cached_network_image/cached_network_image.dart';
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
      options: CarouselOptions(
        height: 230,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        viewportFraction: 1.0,
      ),
      items: bannersList == null
          ? dummyBanner.map((e) {
              return Builder(
                builder: (BuildContext context) {
                  return CachedNetworkImage(
                    height: 100,
                    imageUrl: e.bannerImg,
                    fit: BoxFit.fill,
                    /*  errorWidget: (context, url, error) => Icon(Icons.waiting), */
                  );
                },
              );
            }).toList()
          : bannersList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return CachedNetworkImage(
                    height: 100,
                    imageUrl: i.bannerImg,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
              );
            }).toList(),
    );
  }
}
