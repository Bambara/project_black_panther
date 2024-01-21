// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventMatch _$EventMatchFromJson(Map<String, dynamic> json) => EventMatch(
      json['_id'] as String,
      json['name'] as String,
      json['start_date'] as String,
      json['start_time'] as String,
      json['end_date'] as String,
      json['end_time'] as String,
      json['status'] as String,
      json['te_id'] as String,
      json['tournament_id'] as String,
      MatchPlace.fromJson(json['match_place'] as Map<String, dynamic>),
      MatchResult.fromJson(json['match_results'] as Map<String, dynamic>),
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$EventMatchToJson(EventMatch instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'start_date': instance.startDate,
      'start_time': instance.startTime,
      'end_date': instance.endDate,
      'end_time': instance.endTime,
      'status': instance.status,
      'te_id': instance.teId,
      'tournament_id': instance.tournamentId,
      'match_place': instance.matchPlace.toJson(),
      'match_results': instance.matchResults.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
