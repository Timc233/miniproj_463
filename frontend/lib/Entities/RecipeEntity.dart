import 'package:json_annotation/json_annotation.dart';

part 'RecipeEntity.g.dart';

@JsonSerializable()
class RecipeEntity {
  final int userDefinedRecipeId;
  final String recipeDescription;
  final double totalCalories;
  final List<RecipeFoodEntity> foods;

  RecipeEntity({
    required this.userDefinedRecipeId,
    required this.recipeDescription,
    required this.totalCalories,
    required this.foods,
  });
  factory RecipeEntity.fromJson(Map<String, dynamic> json) => _$RecipeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeEntityToJson(this);
}

@JsonSerializable()
class RecipeFoodEntity {
  final int recipeId; //id for each food, different from one above
  final String foodName;
  final double caloriePerServing;
  final double servingSize;
  final String servingSizeUnit;
  final double amount;

  RecipeFoodEntity({
    required this.recipeId,
    required this.foodName,
    required this.caloriePerServing,
    required this.servingSize,
    required this.servingSizeUnit,
    required this.amount,
  });
  factory RecipeFoodEntity.fromJson(Map<String, dynamic> json) => _$RecipeFoodEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeFoodEntityToJson(this);
}

