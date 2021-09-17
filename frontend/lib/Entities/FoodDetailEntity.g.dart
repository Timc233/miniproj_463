// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodDetailEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodDetailEntity _$FoodDetailEntityFromJson(Map<String, dynamic> json) {
  return FoodDetailEntity(
    fdcId: json['fdcId'] as int,
    servingSize: (json['servingSize'] as num).toDouble(),
    foodName: json['foodName'] as String,
    servingSizeUnit: json['servingSizeUnit'] as String,
    nutrients: (json['nutrients'] as List<dynamic>)
        .map((e) => NutrientsEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FoodDetailEntityToJson(FoodDetailEntity instance) =>
    <String, dynamic>{
      'fdcId': instance.fdcId,
      'servingSize': instance.servingSize,
      'foodName': instance.foodName,
      'servingSizeUnit': instance.servingSizeUnit,
      'nutrients': instance.nutrients,
    };

NutrientsEntity _$NutrientsEntityFromJson(Map<String, dynamic> json) {
  return NutrientsEntity(
    Attribute: json['Attribute'] as String,
    Value: (json['Value'] as num).toDouble(),
  );
}

Map<String, dynamic> _$NutrientsEntityToJson(NutrientsEntity instance) =>
    <String, dynamic>{
      'Attribute': instance.Attribute,
      'Value': instance.Value,
    };
