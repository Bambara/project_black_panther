// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_teams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerTeams _$PlayerTeamsFromJson(Map<String, dynamic> json) => PlayerTeams(
      (json['player_teams'] as List<dynamic>).map((e) => PlayerTeam.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$PlayerTeamsToJson(PlayerTeams instance) => <String, dynamic>{
      'player_teams': instance.playerTeams.map((e) => e.toJson()).toList(),
    };
