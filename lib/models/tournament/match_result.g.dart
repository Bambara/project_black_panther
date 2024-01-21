// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchResult _$MatchResultFromJson(Map<String, dynamic> json) => MatchResult(
      (json['win_teams'] as List<dynamic>).map((e) => WinTeam.fromJson(e as Map<String, dynamic>)).toList(),
      (json['awards'] as List<dynamic>).map((e) => MatchAward.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MatchResultToJson(MatchResult instance) => <String, dynamic>{
      'win_teams': instance.winTeams.map((e) => e.toJson()).toList(),
      'awards': instance.awards.map((e) => e.toJson()).toList(),
    };
