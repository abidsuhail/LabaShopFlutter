class PaymentRequestModel {
  String id;
  String phone;
  String email;
  String buyerName;
  String amount;
  String purpose;
  String status;
  bool sendSms;
  bool sendEmail;
  String smsStatus;
  String emailStatus;
  String shorturl;
  String longurl;
  String redirectUrl;
  String webhook;
  String createdAt;
  String modifiedAt;
  String message = '';
  int error = 0;
  bool allowRepeatedPayments;

  PaymentRequestModel(
      {this.id,
      this.phone,
      this.email,
      this.buyerName,
      this.amount,
      this.purpose,
      this.status,
      this.sendSms,
      this.sendEmail,
      this.smsStatus,
      this.emailStatus,
      this.shorturl,
      this.longurl,
      this.redirectUrl,
      this.webhook,
      this.createdAt,
      this.modifiedAt,
      this.allowRepeatedPayments});

  PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    buyerName = json['buyer_name'];
    amount = json['amount'];
    purpose = json['purpose'];
    status = json['status'];
    sendSms = json['send_sms'];
    sendEmail = json['send_email'];
    smsStatus = json['sms_status'];
    emailStatus = json['email_status'];
    shorturl = json['shorturl'];
    longurl = json['longurl'];
    redirectUrl = json['redirect_url'];
    webhook = json['webhook'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    allowRepeatedPayments = json['allow_repeated_payments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['buyer_name'] = this.buyerName;
    data['amount'] = this.amount;
    data['purpose'] = this.purpose;
    data['status'] = this.status;
    data['send_sms'] = this.sendSms;
    data['send_email'] = this.sendEmail;
    data['sms_status'] = this.smsStatus;
    data['email_status'] = this.emailStatus;
    data['shorturl'] = this.shorturl;
    data['longurl'] = this.longurl;
    data['redirect_url'] = this.redirectUrl;
    data['webhook'] = this.webhook;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    data['allow_repeated_payments'] = this.allowRepeatedPayments;

    return data;
  }
}