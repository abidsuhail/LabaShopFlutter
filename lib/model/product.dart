class Product {
  int productId;
  int itemCount;
  int qty;
  String cost;
  String sessionId;
  String productName;
  List<String> productImg;
  String productBrand;
  String productShortDesc;
  String productManufacturer;
  String sellPrice;
  String productCountry;
  int categoryId;
  String categoryName;
  String subMenu;
  int subCategoryId;
  String subCategoryName;
  String size;
  List<Price> price;

  Product(
      {this.productId,
        this.itemCount,
        this.qty,
        this.cost,
        this.sessionId,
        this.productName,
        this.productImg,
        this.productBrand,
        this.productShortDesc,
        this.productManufacturer,
        this.sellPrice,
        this.productCountry,
        this.categoryId,
        this.categoryName,
        this.subMenu,
        this.subCategoryId,
        this.subCategoryName,
        this.price});



  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    itemCount = json['item_count'];
    qty = json['qty'];
    cost = json['cost'];
    sessionId = json['sessionId'];
    productName = json['product_name'];
    productImg = json['product_img'].cast<String>();
    productBrand = json['product_brand'];
    productShortDesc = json['product_short_desc'];
    productManufacturer = json['product_manufacturer'];
    sellPrice = json['sell_price'];
    productCountry = json['product_country'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subMenu = json['sub_menu'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    if (json['price'] != null) {
      price = new List<Price>();
      json['price'].forEach((v) {
        price.add(new Price.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['item_count'] = this.itemCount;
    data['qty'] = this.qty;
    data['cost'] = this.cost;
    data['sessionId'] = this.sessionId;
    data['product_name'] = this.productName;
    data['product_img'] = this.productImg;
    data['product_brand'] = this.productBrand;
    data['product_short_desc'] = this.productShortDesc;
    data['product_manufacturer'] = this.productManufacturer;
    data['sell_price'] = this.sellPrice;
    data['product_country'] = this.productCountry;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['sub_menu'] = this.subMenu;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_category_name'] = this.subCategoryName;
    if (this.price != null) {
      data['price'] = this.price.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Price {
  String size;
  String cost;
  String unit;

  Price({this.size, this.cost, this.unit});

  Price.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    cost = json['cost'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['cost'] = this.cost;
    data['unit'] = this.unit;
    return data;
  }
}
class Cart {
  String pid;
  String sid;
  String qty;
  String cost;
  String size;

  Cart({this.pid, this.sid, this.qty, this.cost, this.size});

  Cart.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    sid = json['sid'];
    qty = json['qty'];
    cost = json['cost'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['sid'] = this.sid;
    data['qty'] = this.qty;
    data['cost'] = this.cost;
    data['size'] = this.size;
    return data;
  }
}

class ProductList
{
  final List<Product> products;
  ProductList({this.products});
  factory ProductList.fromJson(List<dynamic> parsedJson) {

    List<Product> products = parsedJson.map((i)=>Product.fromJson(i)).toList();
    return new ProductList(
      products: products,
    );
  }
}