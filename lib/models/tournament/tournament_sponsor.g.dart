// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_sponsor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentSponsor _$TournamentSponsorFromJson(Map<String, dynamic> json) => TournamentSponsor(
      json['_id'] as String,
      json['sponsor_id'] as String,
      json['type'] as String,
      json['coverage'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$TournamentSponsorToJson(TournamentSponsor instance) => <String, dynamic>{
      '_id': instance.id,
      'sponsor_id': instance.sponsorId,
      'type': instance.type,
      'coverage': instance.coverage,
      'status': instance.status,
    };
