import 'package:json_annotation/json_annotation.dart';

part 'UserEntity.g.dart';

@JsonSerializable()
class UserEntity {
  final int userId;

  UserEntity({
    required this.userId,
  });
  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

