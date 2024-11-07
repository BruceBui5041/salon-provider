class SubscriptionPlanModel {
  String? title;
  String? subtext;
  List<String>? benefits;

  SubscriptionPlanModel({this.title, this.subtext, this.benefits});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtext = json['subtext'];
    benefits = json['benefits'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtext'] = subtext;
    data['benefits'] = benefits;
    return data;
  }
}
