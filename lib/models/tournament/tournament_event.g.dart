// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentEvent _$TournamentEventFromJson(Map<String, dynamic> json) => TournamentEvent(
      json['_id'] as String,
      json['event_name'] as String,
      json['event_type'] as String,
      json['team_type'] as String,
      (json['art_works'] as List<dynamic>).map((e) => ArtWork.fromJson(e as Map<String, dynamic>)).toList(),
      json['status'] as String,
      json['game_id'] as String,
      json['tournament_id'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$TournamentEventToJson(TournamentEvent instance) => <String, dynamic>{
      '_id': instance.id,
      'event_name': instance.eventName,
      'event_type': instance.eventType,
      'team_type': instance.teamType,
      'art_works': instance.artWorks.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'game_id': instance.gameId,
      'tournament_id': instance.tournamentId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
