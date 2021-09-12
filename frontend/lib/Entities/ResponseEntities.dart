
import 'package:json_annotation/json_annotation.dart';
import 'Entities.dart';

part 'ResponseEntities.g.dart';

@JsonSerializable()
class FoodResponse {
  final int responseCode;
  final String message;
  final FoodEntity data;

  FoodResponse({
    required this.responseCode,
    required this.message,
    required this.data,
  });
  factory FoodResponse.fromJson(Map<String, dynamic> json) => _$FoodResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FoodResponseToJson(this);
}
