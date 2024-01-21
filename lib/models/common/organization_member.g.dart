// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationMember _$OrganizationMemberFromJson(Map<String, dynamic> json) => OrganizationMember(
      json['_id'] as String,
      json['level'] as String,
      json['member_id'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$OrganizationMemberToJson(OrganizationMember instance) => <String, dynamic>{
      '_id': instance.id,
      'level': instance.level,
      'member_id': instance.memberId,
      'status': instance.status,
    };
