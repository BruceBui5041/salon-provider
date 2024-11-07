class PaymentHistoryModel {
  String? title;
  String? bookingId;
  String? price;
  String? paymentId;
  String? methodType;
  String? status;
  Customer? customer;

  PaymentHistoryModel(
      {this.title,
        this.bookingId,
        this.price,
        this.paymentId,
        this.methodType,
        this.status,
        this.customer});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    bookingId = json['booking_id'];
    price = json['price'];
    paymentId = json['payment_id'];
    methodType = json['method_type'];
    status = json['status'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['booking_id'] = bookingId;
    data['price'] = price;
    data['payment_id'] = paymentId;
    data['method_type'] = methodType;
    data['status'] = status;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? image;
  String? title;

  Customer({this.image, this.title});

  Customer.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
