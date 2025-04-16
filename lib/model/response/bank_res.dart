// ID                int    `json:"id"`
// Name              string `json:"name"`
// Code              string `json:"code"`
// Bin               string `json:"bin"`
// ShortName         string `json:"short_name"`
// Logo              string `json:"logo"`
// TransferSupported bool   `json:"transfer_supported"`
// LookupSupported   bool   `json:"lookup_supported"`

import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';

part 'bank_res.g.dart';

@JsonSerializable()
class Bank {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "bin")
  String? bin;
  @JsonKey(name: "short_name")
  String? shortName;
  @JsonKey(name: "logo")
  String? logo;

  Bank({
    this.id,
    this.name,
    this.code,
    this.bin,
    this.shortName,
    this.logo,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}
