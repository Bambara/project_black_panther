// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountType _$UserAccountTypeFromJson(Map<String, dynamic> json) => UserAccountType(
      json['_id'] as String,
      json['type'] as String,
      json['status'] as bool,
    );

Map<String, dynamic> _$UserAccountTypeToJson(UserAccountType instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'status': instance.status,
    };
