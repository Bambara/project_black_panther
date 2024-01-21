// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_team_assigns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTeamAssigns _$EventTeamAssignsFromJson(Map<String, dynamic> json) => EventTeamAssigns(
      (json['assignTeams'] as List<dynamic>).map((e) => EventTeamAssign.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$EventTeamAssignsToJson(EventTeamAssigns instance) => <String, dynamic>{
      'assignTeams': instance.assignTeams.map((e) => e.toJson()).toList(),
    };
