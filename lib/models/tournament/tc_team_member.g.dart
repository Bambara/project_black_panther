// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_team_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TCTeamMember _$TCTeamMemberFromJson(Map<String, dynamic> json) => TCTeamMember(
      json['_id'] as String,
      json['user_id'] as String,
      json['role'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$TCTeamMemberToJson(TCTeamMember instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'role': instance.role,
      'status': instance.status,
    };
