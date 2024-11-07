class RecentBookingModel {
  String? image;
  bool? isExpand;
  String? name;
  String? price;
  String? offer;
  String? date;
  String? time;
  String? serviceman;
  List<ServicemanLists>? servicemanLists;

  RecentBookingModel(
      {this.image,
        this.isExpand,
        this.name,
        this.price,
        this.offer,
        this.date,
        this.time,
        this.serviceman,
        this.servicemanLists});

  RecentBookingModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    isExpand = json['isExpand'];
    name = json['name'];
    price = json['price'];
    offer = json['offer'];
    date = json['date'];
    time = json['time'];
    serviceman = json['serviceman'];
    if (json['servicemanLists'] != null) {
      servicemanLists = <ServicemanLists>[];
      json['servicemanLists'].forEach((v) {
        servicemanLists!.add(ServicemanLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['isExpand'] = isExpand;
    data['name'] = name;
    data['price'] = price;
    data['offer'] = offer;
    data['date'] = date;
    data['time'] = time;
    data['serviceman'] = serviceman;
    if (servicemanLists != null) {
      data['servicemanLists'] =
          servicemanLists!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['role'] = role;
    data['image'] = image;
    data['title'] = title;
    data['rate'] = rate;
    return data;
  }
}
