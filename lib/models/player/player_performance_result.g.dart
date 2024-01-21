// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_performance_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerPerformanceResult _$PlayerPerformanceResultFromJson(Map<String, dynamic> json) => PlayerPerformanceResult(
      (json['match_count'] as num).toDouble(),
      (json['win_count'] as num).toDouble(),
      (json['toxic_level'] as num).toDouble(),
      (json['average_damage'] as num).toDouble(),
      (json['average_skill'] as num).toDouble(),
      (json['mvp_count'] as num).toDouble(),
      json['remark'] as String,
    );

Map<String, dynamic> _$PlayerPerformanceResultToJson(PlayerPerformanceResult instance) => <String, dynamic>{
      'match_count': instance.matchCount,
      'win_count': instance.winCount,
      'toxic_level': instance.toxicLevel,
      'average_damage': instance.averageDamage,
      'average_skill': instance.averageSkill,
      'mvp_count': instance.mvpCount,
      'remark': instance.remark,
    };
