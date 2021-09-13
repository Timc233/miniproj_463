
import 'package:json_annotation/json_annotation.dart';

part 'FoodEntity.g.dart';

@JsonSerializable()
class FoodEntity {
  final String foodName;
  final double caloriesPerServing;

  FoodEntity({
    required this.foodName,
    required this.caloriesPerServing,
  });
  factory FoodEntity.fromJson(Map<String, dynamic> json) => _$FoodEntityFromJson(json);
  Map<String, dynamic> toJson() => _$FoodEntityToJson(this);
}

