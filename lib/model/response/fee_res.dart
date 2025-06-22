import 'package:salon_provider/common/fee_type.dart';
import 'package:salon_provider/model/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:salon_provider/model/response/booking_response.dart';
import 'package:salon_provider/model/response/role_response.dart';
import 'package:salon_provider/model/response/user_response.dart';

part 'fee_res.g.dart';

@JsonSerializable()
class Fee extends CommonResponse {
  @JsonKey(name: 'type')
  final FeeType? type;

  @JsonKey(name: 'creator')
  final UserResponse? creator;

  @JsonKey(name: 'role')
  final RoleResponse? role;

  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  @JsonKey(name: 'bookings')
  final List<Booking>? bookings;

  @JsonKey(name: 'travel_fee_per_km')
  final String? travelFeePerKm;

  @JsonKey(name: 'free_travel_fee_at')
  final String? freeTravelFeeAt;

  Fee({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
    this.type,
    this.creator,
    this.role,
    this.publishedAt,
    this.bookings,
    this.travelFeePerKm,
    this.freeTravelFeeAt,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);
}
