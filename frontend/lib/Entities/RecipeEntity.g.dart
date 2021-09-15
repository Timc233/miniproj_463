// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecipeEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeEntity _$RecipeEntityFromJson(Map<String, dynamic> json) {
  return RecipeEntity(
    recipeId: json['recipeId'] as int,
    recipeDescription: json['recipeDescription'] as String,
    totalCalories: (json['totalCalories'] as num).toDouble(),
    foods: (json['foods'] as List<dynamic>)
        .map((e) => RecipeFoodEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RecipeEntityToJson(RecipeEntity instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'recipeDescription': instance.recipeDescription,
      'totalCalories': instance.totalCalories,
      'foods': instance.foods,
    };

RecipeFoodEntity _$RecipeFoodEntityFromJson(Map<String, dynamic> json) {
  return RecipeFoodEntity(
    recipeId: json['recipeId'] as int,
    foodName: json['foodName'] as String,
    caloriePerServing: (json['caloriePerServing'] as num).toDouble(),
    servingSize: (json['servingSize'] as num).toDouble(),
    servingSizeUnit: json['servingSizeUnit'] as String,
    amount: (json['amount'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RecipeFoodEntityToJson(RecipeFoodEntity instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'foodName': instance.foodName,
      'caloriePerServing': instance.caloriePerServing,
      'servingSize': instance.servingSize,
      'servingSizeUnit': instance.servingSizeUnit,
      'amount': instance.amount,
    };
