// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodEntity _$FoodEntityFromJson(Map<String, dynamic> json) {
  return FoodEntity(
    foodName: json['foodName'] as String,
    caloriesPerServing: (json['caloriesPerServing'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FoodEntityToJson(FoodEntity instance) =>
    <String, dynamic>{
      'foodName': instance.foodName,
      'caloriesPerServing': instance.caloriesPerServing,
    };
