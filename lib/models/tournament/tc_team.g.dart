// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tc_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TCTeam _$TCTeamFromJson(Map<String, dynamic> json) => TCTeam(
      json['_id'] as String,
      json['code'] as String,
      json['name'] as String,
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      json['role'] as String,
      json['status'] as String,
      (json['members'] as List<dynamic>).map((e) => TCTeamMember.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$TCTeamToJson(TCTeam instance) => <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'avatar': instance.avatar.toJson(),
      'role': instance.role,
      'status': instance.status,
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
