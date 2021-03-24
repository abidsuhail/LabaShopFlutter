class Address {
  String name;
  int addressId;
  String address1;
  String address2;
  String landmark;
  String city;
  String state;
  String country;
  String pin;

  Address(
      {this.name,
      this.addressId,
      this.address1,
      this.address2,
      this.landmark,
      this.city,
      this.state,
      this.country,
      this.pin});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addressId = json['addressId'];
    address1 = json['address1'];
    address2 = json['address2'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['addressId'] = this.addressId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin'] = this.pin;
    return data;
  }
}

class AddressList {
  final List<Address> address;
  AddressList({this.address});
  factory AddressList.fromJson(List<dynamic> parsedJson) {
    List<Address> address = parsedJson.map((i) => Address.fromJson(i)).toList();
    return new AddressList(
      address: address,
    );
  }
}
