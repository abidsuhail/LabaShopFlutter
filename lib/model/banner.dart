class Banner {
  int bannerId;
  String bannerImg;
  String bannerLink;

  Banner({this.bannerId, this.bannerImg, this.bannerLink});

  Banner.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    bannerImg = json['banner_img'];
    bannerLink = json['banner_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['banner_img'] = this.bannerImg;
    data['banner_link'] = this.bannerLink;
    return data;
  }
}
class BannerList
{
  final List<Banner> banners;
  BannerList({this.banners});
  factory BannerList.fromJson(List<dynamic> parsedJson) {

    List<Banner> users = parsedJson.map((i)=>Banner.fromJson(i)).toList();
    return new BannerList(
      banners: users,
    );
  }
}