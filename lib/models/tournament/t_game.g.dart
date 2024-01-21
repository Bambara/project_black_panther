// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TGame _$TGameFromJson(Map<String, dynamic> json) => TGame(
      json['_id'] as String,
      json['game_id'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$TGameToJson(TGame instance) => <String, dynamic>{
      '_id': instance.id,
      'game_id': instance.gameId,
      'status': instance.status,
    };
