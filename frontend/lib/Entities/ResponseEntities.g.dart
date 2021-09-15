// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseEntities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodSearchResponse _$FoodSearchResponseFromJson(Map<String, dynamic> json) {
  return FoodSearchResponse(
    responseCode: json['responseCode'] as int,
    message: json['message'] as String,
    data: FoodEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FoodSearchResponseToJson(FoodSearchResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'message': instance.message,
      'data': instance.data,
    };

FoodDetailSearchResponse _$FoodDetailSearchResponseFromJson(
    Map<String, dynamic> json) {
  return FoodDetailSearchResponse(
    responseCode: json['responseCode'] as int,
    message: json['message'] as String,
    data: FoodDetailEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FoodDetailSearchResponseToJson(
        FoodDetailSearchResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'message': instance.message,
      'data': instance.data,
    };

StringDataResponse _$StringDataResponseFromJson(Map<String, dynamic> json) {
  return StringDataResponse(
    responseCode: json['responseCode'] as int,
    message: json['message'] as String,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$StringDataResponseToJson(StringDataResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'message': instance.message,
      'data': instance.data,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    responseCode: json['responseCode'] as int,
    message: json['message'] as String,
    data: UserEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'message': instance.message,
      'data': instance.data,
    };
