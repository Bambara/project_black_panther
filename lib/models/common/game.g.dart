// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['_id'] as String,
      json['name'] as String,
      Avatar.fromJson(json['poster'] as Map<String, dynamic>),
      json['age_category'] as String,
      json['publisher_id'] as String,
      json['play_type'] as String,
      json['player_type'] as String,
      json['status'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$GameToJson(Game instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'poster': instance.poster.toJson(),
      'age_category': instance.ageCategory,
      'publisher_id': instance.publisherId,
      'play_type': instance.playType,
      'player_type': instance.playerType,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
