// CreatorID       uint32 `json:"-" gorm:"column:creator_id;not null;index"`
// Creator         *User  `json:"creator,omitempty" gorm:"foreignKey:CreatorID"`
// Name            string `json:"name" gorm:"column:bank_name;type:varchar(100);not null"`
// Code            string `json:"code" gorm:"column:bank_code;type:varchar(20);not null"`
// Bin             string `json:"bin" gorm:"column:bank_bin;type:varchar(20)"`
// ShortName       string `json:"short_name" gorm:"column:bank_short_name;type:varchar(50)"`
// Logo            string `json:"logo" gorm:"column:bank_logo;type:varchar(255)"`
// AccountName     string `json:"account_name" gorm:"column:account_name;type:varchar(100);not null"`
// AccountNumber   string `json:"account_number" gorm:"column:account_number;type:varchar(50);not null;uniqueIndex"`
// SwiftCode       string `json:"swift_code" gorm:"column:swift_code;type:varchar(20)"`
// IsDefault       bool   `json:"is_default" gorm:"column:is_default;default:false"`
// Notes           string `json:"notes" gorm:"column:notes;type:text"`

import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/base_response.dart';

part 'bank_account_res.g.dart';

@JsonSerializable()
class BankAccountRes extends CommonResponse {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'bin')
  final String? bin;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'logo')
  final String? logo;
  @JsonKey(name: 'account_name')
  final String? accountName;
  @JsonKey(name: 'account_number')
  final String? accountNumber;
  @JsonKey(name: 'swift_code')
  final String? swiftCode;
  @JsonKey(name: 'is_default')
  final bool? isDefault;
  @JsonKey(name: 'notes')
  final String? notes;

  BankAccountRes({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.status,
    this.name,
    this.code,
    this.bin,
    this.shortName,
    this.logo,
    this.accountName,
    this.accountNumber,
    this.swiftCode,
    this.isDefault,
    this.notes,
  });

  factory BankAccountRes.fromJson(Map<String, dynamic> json) =>
      _$BankAccountResFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountResToJson(this);

  // Override equality for proper comparison in dropdown
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BankAccountRes) return false;

    // Use a combination of fields to determine equality
    return id == other.id &&
        accountNumber == other.accountNumber &&
        (accountNumber != null || (name == other.name && code == other.code));
  }

  @override
  int get hashCode => Object.hash(id, accountNumber, name, code);
}
