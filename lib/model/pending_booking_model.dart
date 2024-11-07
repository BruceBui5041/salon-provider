import 'booking_details_model.dart';

class PendingBookingModel {
  String? image;
  String? status;
  String? bookingId;
  String? packageId;
  String? title;
  String? rate;
  String? date;
  String? time;
  String? location;
  String? description,assignMe;
  int? requiredServicemen;
  Customer? customer;
  List<ServicemanList>? servicemanList;

  PendingBookingModel(
      {this.image,
        this.status,
        this.bookingId,
        this.title,
        this.rate,
        this.date,
        this.time,
        this.location,
        this.description,
        this.customer,
        this.servicemanList,this.packageId,this.requiredServicemen,this.assignMe});

  PendingBookingModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    status = json['status'];
    bookingId = json['bookingId'];
    packageId = json['package_id'];
    assignMe = json['assign_me'];
    title = json['title'];
    rate = json['rate'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
    description = json['description'];
    requiredServicemen = json['required_servicemen'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    if (json['servicemanList'] != null) {
      servicemanList = <ServicemanList>[];
      json['servicemanList'].forEach((v) {
        servicemanList!.add(ServicemanList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['status'] = status;
    data['bookingId'] = bookingId;
    data['package_id'] = packageId;
    data['assign_me'] = assignMe;
    data['title'] = title;
    data['rate'] = rate;
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    data['description'] = description;
    data['required_servicemen'] = requiredServicemen;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (servicemanList != null) {
      data['servicemanList'] =
          servicemanList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? image;
  String? title;
  String? rate;
  String? experience;
  String? email;
  String? phone;
  String? location;
  List<Media>? media;

  Customer(
      {this.image,
        this.title,
        this.rate,
        this.experience,
        this.email,
        this.phone,
        this.location, this.media});

  Customer.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    rate = json['rate'];
    experience = json['experience'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['rate'] = rate;
    data['experience'] = experience;
    data['email'] = email;
    data['phone'] = phone;
    data['location'] = location;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicemanList {
  String? image;
  String? title;
  double? rate;
  String? experience;

  ServicemanList({this.image, this.title, this.rate, this.experience});

  ServicemanList.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    rate = json['rate'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['rate'] = rate;
    data['experience'] = experience;
    return data;
  }
}
