// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseEntities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodResponse _$FoodResponseFromJson(Map<String, dynamic> json) {
  return FoodResponse(
    responseCode: json['responseCode'] as int,
    message: json['message'] as String,
    data: FoodEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FoodResponseToJson(FoodResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'message': instance.message,
      'data': instance.data,
    };
