// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderType _$ReminderTypeFromJson(Map<String, dynamic> json) => ReminderType(
      json['_id'] as String,
      json['type'] as String,
      json['status'] as bool,
    );

Map<String, dynamic> _$ReminderTypeToJson(ReminderType instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'status': instance.status,
    };
