// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_award.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchAward _$MatchAwardFromJson(Map<String, dynamic> json) => MatchAward(
      json['_id'] as String,
      json['award_id'] as String,
      json['winner_id'] as String,
      json['winner_type'] as String,
    );

Map<String, dynamic> _$MatchAwardToJson(MatchAward instance) => <String, dynamic>{
      '_id': instance.id,
      'award_id': instance.awardId,
      'winner_id': instance.winnerId,
      'winner_type': instance.winnerType,
    };
