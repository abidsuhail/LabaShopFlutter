class OrderDetails {
  int orderId;
  String orderNumber;
  String payableAmount;
  String paymentMode;
  String orderStatus;
  String postedOn;
  int productId;
  int qty;
  String cost;
  List<Price> price;
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

  OrderDetails(
      {this.orderId,
      this.orderNumber,
      this.payableAmount,
      this.paymentMode,
      this.orderStatus,
      this.postedOn,
      this.productId,
      this.qty,
      this.cost,
      this.price,
      this.productName,
      this.productImg,
      this.productBrand,
      this.productShortDesc,
      this.productManufacturer,
      this.sellPrice,
      this.productCountry,
      this.categoryId,
      this.categoryName,
      this.subMenu});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    payableAmount = json['payable_amount'];
    paymentMode = json['payment_mode'];
    orderStatus = json['order_status'];
    postedOn = json['posted_on'];
    productId = json['product_id'];
    qty = json['qty'];
    cost = json['cost'];
    if (json['price'] != null) {
      price = new List<Price>();
      json['price'].forEach((v) {
        price.add(new Price.fromJson(v));
      });
    }
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['payable_amount'] = this.payableAmount;
    data['payment_mode'] = this.paymentMode;
    data['order_status'] = this.orderStatus;
    data['posted_on'] = this.postedOn;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['cost'] = this.cost;
    if (this.price != null) {
      data['price'] = this.price.map((v) => v.toJson()).toList();
    }
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

class OrderDetailsList {
  final List<OrderDetails> orderDetails;
  OrderDetailsList({this.orderDetails});
  factory OrderDetailsList.fromJson(List<dynamic> parsedJson) {
    List<OrderDetails> orderDetailsList =
        parsedJson.map((i) => OrderDetails.fromJson(i)).toList();
    return new OrderDetailsList(
      orderDetails: orderDetailsList,
    );
  }
}
