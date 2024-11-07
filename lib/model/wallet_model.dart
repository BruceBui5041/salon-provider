class WalletModel {
  int? id;
  int? consumerId;
  int? balance;

  WalletModel({this.id, this.consumerId, this.balance});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consumerId = json['consumer_id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['consumer_id'] = consumerId;
    data['balance'] = balance;
    return data;
  }
}