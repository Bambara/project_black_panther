// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerTeam _$PlayerTeamFromJson(Map<String, dynamic> json) => PlayerTeam(
      json['_id'] as String,
      json['name'] as String,
      json['code'] as String,
      Avatar.fromJson(json['logo'] as Map<String, dynamic>),
      json['team_type'] as String,
      json['clan_id'] as String,
      json['club_id'] as String,
      (json['members'] as List<dynamic>).map((e) => PTMember.fromJson(e as Map<String, dynamic>)).toList(),
      json['status'] as String,
      json['tournament_id'] as String,
    );

Map<String, dynamic> _$PlayerTeamToJson(PlayerTeam instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'logo': instance.logo.toJson(),
      'team_type': instance.teamType,
      'clan_id': instance.clanId,
      'club_id': instance.clubId,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'tournament_id': instance.tournamentId,
    };
