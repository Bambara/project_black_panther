// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_team_assign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTeamAssign _$EventTeamAssignFromJson(Map<String, dynamic> json) => EventTeamAssign(
      json['_id'] as String,
      json['status'] as String,
      json['card_color'] as String,
      json['ptl_id'] as String,
      json['te_id'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$EventTeamAssignToJson(EventTeamAssign instance) => <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'card_color': instance.cardColor,
      'ptl_id': instance.ptlId,
      'te_id': instance.teId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
