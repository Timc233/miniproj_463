
import 'package:json_annotation/json_annotation.dart';
import 'Entities.dart';

part 'ResponseEntities.g.dart';

@JsonSerializable()
class FoodSearchResponse {
  final int responseCode;
  final String message;
  final FoodEntity data;

  FoodSearchResponse({
    required this.responseCode,
    required this.message,
    required this.data,
  });
  factory FoodSearchResponse.fromJson(Map<String, dynamic> json) => _$FoodSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FoodSearchResponseToJson(this);
}

@JsonSerializable()
class FoodDetailSearchResponse {
  final int responseCode;
  final String message;
  final FoodDetailEntity data;

  FoodDetailSearchResponse({
    required this.responseCode,
    required this.message,
    required this.data,
  });
  factory FoodDetailSearchResponse.fromJson(Map<String, dynamic> json) => _$FoodDetailSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FoodDetailSearchResponseToJson(this);
}

@JsonSerializable()
class RecipeSearchResponse {
  final int responseCode;
  final String message;
  final List<RecipeEntity> data;

  RecipeSearchResponse({
    required this.responseCode,
    required this.message,
    required this.data,
  });
  factory RecipeSearchResponse.fromJson(Map<String, dynamic> json) => _$RecipeSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeSearchResponseToJson(this);
}

@JsonSerializable()
class StringDataResponse {
  final int responseCode;
  final String message;
  final String data;

  StringDataResponse({
    required this.responseCode,
    required this.message,
    required this.data,
  });
  factory StringDataResponse.fromJson(Map<String, dynamic> json) => _$StringDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StringDataResponseToJson(this);
}

@JsonSerializable()
class UserResponse {
  final int responseCode;
  final String message;
  final UserEntity data;

  UserResponse({
    required this.responseCode,
    required this.message,
    required this.data,
  });
  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}


