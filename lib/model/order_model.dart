class OrderModel {
  int orderId;
  String orderNumber;
  String payableAmount;
  String paymentMode;
  String orderStatus;
  String name;
  String email;
  String mobile;
  String address;
  String landmark;
  String pincode;
  String city;
  String state;
  String country;
  String postedOn;
  int itemCount;

  OrderModel(
      {this.orderId,
      this.orderNumber,
      this.payableAmount,
      this.paymentMode,
      this.orderStatus,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.landmark,
      this.pincode,
      this.city,
      this.state,
      this.country,
      this.postedOn,
      this.itemCount});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderNumber = json['order_number'];
    payableAmount = json['payable_amount'];
    paymentMode = json['payment_mode'];
    orderStatus = json['order_status'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postedOn = json['posted_on'];
    itemCount = json['item_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_number'] = this.orderNumber;
    data['payable_amount'] = this.payableAmount;
    data['payment_mode'] = this.paymentMode;
    data['order_status'] = this.orderStatus;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['posted_on'] = this.postedOn;
    data['item_count'] = this.itemCount;
    return data;
  }
}

class OrderModelList {
  final List<OrderModel> orderModels;
  OrderModelList({this.orderModels});
  factory OrderModelList.fromJson(List<dynamic> parsedJson) {
    List<OrderModel> orderDetailsList =
        parsedJson.map((i) => OrderModel.fromJson(i)).toList();
    return new OrderModelList(
      orderModels: orderDetailsList,
    );
  }
}
