// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      json['_id'] as String,
      json['name'] as String,
      Avatar.fromJson(json['logo'] as Map<String, dynamic>),
      json['type'] as String,
      json['status'] as String,
      (json['members'] as List<dynamic>).map((e) => OrganizationMember.fromJson(e as Map<String, dynamic>)).toList(),
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'logo': instance.logo.toJson(),
      'type': instance.type,
      'status': instance.status,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
