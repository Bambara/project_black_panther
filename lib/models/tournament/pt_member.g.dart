// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pt_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PTMember _$PTMemberFromJson(Map<String, dynamic> json) => PTMember(
      json['_id'] as String,
      json['is_leader'] as bool,
      json['remark'] as String,
      json['status'] as String,
      json['default_ign'] as String,
      json['player_profile_id'] as String,
    );

Map<String, dynamic> _$PTMemberToJson(PTMember instance) => <String, dynamic>{
      '_id': instance.id,
      'is_leader': instance.isLeader,
      'remark': instance.remark,
      'status': instance.status,
      'default_ign': instance.defaultIgn,
      'player_profile_id': instance.playerProfileId,
    };
