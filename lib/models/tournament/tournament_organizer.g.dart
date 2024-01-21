// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_organizer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentOrganizer _$TournamentOrganizerFromJson(Map<String, dynamic> json) => TournamentOrganizer(
      json['_id'] as String,
      json['organization_id'] as String,
      json['type'] as String,
      json['role'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$TournamentOrganizerToJson(TournamentOrganizer instance) => <String, dynamic>{
      '_id': instance.id,
      'organization_id': instance.organizationId,
      'type': instance.type,
      'role': instance.role,
      'status': instance.status,
    };
