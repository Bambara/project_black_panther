// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_game_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerGameList _$PlayerGameListFromJson(Map<String, dynamic> json) => PlayerGameList(
      json['_id'] as String,
      json['ign'] as String,
      (json['play_frequency'] as List<dynamic>).map((e) => PlayFrequency.fromJson(e as Map<String, dynamic>)).toList(),
      json['game_id'] as String,
      PlayerPerformanceResult.fromJson(json['performance_result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerGameListToJson(PlayerGameList instance) => <String, dynamic>{
      '_id': instance.id,
      'ign': instance.ign,
      'play_frequency': instance.playFrequency.map((e) => e.toJson()).toList(),
      'game_id': instance.gameId,
      'performance_result': instance.performanceResult.toJson(),
    };
