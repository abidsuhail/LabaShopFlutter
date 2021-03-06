class Category {
  int categoryId;
  String categoryName;
  String categoryImg;
  String subMenu;
  List<SubCat> subCat;

  Category(
      {this.categoryId,
        this.categoryName,
        this.categoryImg,
        this.subMenu,
        this.subCat});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    subMenu = json['sub_menu'];
    if (json['sub_cat'] != null) {
      subCat = new List<SubCat>();
      json['sub_cat'].forEach((v) {
        subCat.add(new SubCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['sub_menu'] = this.subMenu;
    if (this.subCat != null) {
      data['sub_cat'] = this.subCat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCat {
  int subCategoryId;
  String subCategoryName;
  String subCategoryImg;

  SubCat({this.subCategoryId, this.subCategoryName, this.subCategoryImg});

  SubCat.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    subCategoryImg = json['sub_category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.subCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    data['sub_category_img'] = this.subCategoryImg;
    return data;
  }
}

class CategoryList
{
  final List<Category> categories;
  CategoryList({this.categories});
  factory CategoryList.fromJson(List<dynamic> parsedJson) {

    List<Category> categories = parsedJson.map((i)=>Category.fromJson(i)).toList();
    return new CategoryList(
      categories: categories,
    );
  }
}