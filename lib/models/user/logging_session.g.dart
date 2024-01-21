// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logging_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggingSession _$LoggingSessionFromJson(Map<String, dynamic> json) => LoggingSession(
      json['_id'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['email'] as String,
      json['user_name'] as String,
      json['role'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$LoggingSessionToJson(LoggingSession instance) => <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'user_name': instance.userName,
      'role': instance.role,
      'token': instance.token,
    };
