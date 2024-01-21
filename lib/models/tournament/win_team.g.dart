// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'win_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WinTeam _$WinTeamFromJson(Map<String, dynamic> json) => WinTeam(
      json['_id'] as String,
      json['match_team_id'] as String,
      json['place'] as String,
    );

Map<String, dynamic> _$WinTeamToJson(WinTeam instance) => <String, dynamic>{
      '_id': instance.id,
      'match_team_id': instance.matchTeamId,
      'place': instance.place,
    };
