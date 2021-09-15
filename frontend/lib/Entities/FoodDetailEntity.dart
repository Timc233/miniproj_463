
import 'package:json_annotation/json_annotation.dart';

part 'FoodDetailEntity.g.dart';

@JsonSerializable()
class FoodDetailEntity {
  final int fdcId;
  final double servingSize;
  final String foodName;
  final String servingSizeUnit;
  final NutrientsEntity nutrients;

  FoodDetailEntity({
    required this.fdcId,
    required this.servingSize,
    required this.foodName,
    required this.servingSizeUnit,
    required this.nutrients,
  });
  factory FoodDetailEntity.fromJson(Map<String, dynamic> json) => _$FoodDetailEntityFromJson(json);
  Map<String, dynamic> toJson() => _$FoodDetailEntityToJson(this);
}

@JsonSerializable()
class NutrientsEntity {
  final String Attribute;
  final double Value;

  NutrientsEntity({
    required this.Attribute,
    required this.Value,
  });
  factory NutrientsEntity.fromJson(Map<String, dynamic> json) => _$NutrientsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$NutrientsEntityToJson(this);
}
