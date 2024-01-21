// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organizer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizerProfile _$OrganizerProfileFromJson(Map<String, dynamic> json) => OrganizerProfile(
      json['_id'] as String,
      json['name'] as String,
      json['type'] as String,
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      json['status'] as String,
      json['organization_id'] as String,
      json['user_id'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
      (json['organization'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$OrganizerProfileToJson(OrganizerProfile instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'avatar': instance.avatar.toJson(),
      'status': instance.status,
      'organization_id': instance.organizationId,
      'user_id': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'organization': instance.organization.map((e) => e.toJson()).toList(),
    };
