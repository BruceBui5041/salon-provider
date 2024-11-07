

class BookingModel {
  String? bookingNumber;
  bool? isExpand;
  String? name,image;
  String? price,packageId;
  String? offer;
  String? status;
  String? dateTime;
  String? payment;
  String? location,assignMe;
  int? requiredServicemen;
  List<CustomerList>? customerList;
  List<ServicemanLists>? servicemanLists;

  BookingModel(
      {this.bookingNumber,
        this.packageId,
        this.name,
        this.price,
        this.offer,
        this.status,
        this.image,
        this.dateTime,
        this.payment,
        this.location,
        this.customerList,
        this.servicemanLists,this.isExpand,this.requiredServicemen,this.assignMe});

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingNumber = json['bookingNumber'];
    packageId = json['package_id'];
    isExpand = json['isExpand'];
    name = json['name'];
    price = json['price'];
    offer = json['offer'];
    status = json['status'];
    dateTime = json['dateTime'];
    payment = json['payment'];
    location = json['location'];
    image = json['image'];
    assignMe = json['assign_me'];
    requiredServicemen = json['required_servicemen'];
    if (json['customerList'] != null) {
      customerList = <CustomerList>[];
      json['customerList'].forEach((v) {
        customerList!.add(CustomerList.fromJson(v));
      });
    }
    if (json['servicemanLists'] != null) {
      servicemanLists = <ServicemanLists>[];
      json['servicemanLists'].forEach((v) {
        servicemanLists!.add(ServicemanLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingNumber'] = bookingNumber;
    data['package_id'] = packageId;
    data['isExpand'] = isExpand;
    data['name'] = name;
    data['price'] = price;
    data['offer'] = offer;
    data['status'] = status;
    data['dateTime'] = dateTime;
    data['payment'] = payment;
    data['location'] = location;
    data['image'] = image;
    data['assign_me'] = assignMe;
    data['required_servicemen'] = requiredServicemen;
    if (customerList != null) {
      data['customerList'] = customerList!.map((v) => v.toJson()).toList();
    }
    if (servicemanLists != null) {
      data['servicemanLists'] =
          servicemanLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerList {
  String? role;
  String? image;
  String? title;
  String? rate;

  CustomerList({this.role, this.image, this.title, this.rate});

  CustomerList.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    image = json['image'];
    title = json['title'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['image'] = image;
    data['title'] = title;
    data['rate'] = rate;
    return data;
  }
}

class ServicemanLists {
  String? role;
  String? image;
  String? title;
  String? rate;

  ServicemanLists({this.role, this.image, this.title, this.rate});

  ServicemanLists.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    image = json['image'];
    title = json['title'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['image'] = image;
    data['title'] = title;
    data['rate'] = rate;
    return data;
  }
}
