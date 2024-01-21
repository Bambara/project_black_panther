// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      json['_id'] as String,
      json['name'] as String,
      json['start_date'] as String,
      json['start_time'] as String,
      json['end_date'] as String,
      json['end_time'] as String,
      json['reg_open_date'] as String,
      json['reg_open_time'] as String,
      json['reg_close_date'] as String,
      json['reg_close_time'] as String,
      (json['art_works'] as List<dynamic>).map((e) => ArtWork.fromJson(e as Map<String, dynamic>)).toList(),
      json['type'] as String,
      json['participant_type'] as String,
      json['status'] as String,
      (json['to_list'] as List<dynamic>).map((e) => TournamentOrganizer.fromJson(e as Map<String, dynamic>)).toList(),
      (json['ts_list'] as List<dynamic>).map((e) => TournamentSponsor.fromJson(e as Map<String, dynamic>)).toList(),
      (json['tct_list'] as List<dynamic>).map((e) => TCTeam.fromJson(e as Map<String, dynamic>)).toList(),
      (json['team_groups'] as List<dynamic>).map((e) => TTGroup.fromJson(e as Map<String, dynamic>)).toList(),
      (json['team_sides'] as List<dynamic>).map((e) => TTSide.fromJson(e as Map<String, dynamic>)).toList(),
      (json['tg_list'] as List<dynamic>).map((e) => TGame.fromJson(e as Map<String, dynamic>)).toList(),
      (json['finance_details'] as List<dynamic>).map((e) => TFinanceDetails.fromJson(e as Map<String, dynamic>)).toList(),
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'start_date': instance.startDate,
      'start_time': instance.startTime,
      'end_date': instance.endDate,
      'end_time': instance.endTime,
      'reg_open_date': instance.regOpenDate,
      'reg_open_time': instance.regOpenTime,
      'reg_close_date': instance.regCloseDate,
      'reg_close_time': instance.regCloseTime,
      'art_works': instance.artWorks.map((e) => e.toJson()).toList(),
      'type': instance.type,
      'participant_type': instance.participantType,
      'status': instance.status,
      'to_list': instance.toList.map((e) => e.toJson()).toList(),
      'ts_list': instance.tsList.map((e) => e.toJson()).toList(),
      'tct_list': instance.tctList.map((e) => e.toJson()).toList(),
      'team_groups': instance.teamGroups.map((e) => e.toJson()).toList(),
      'team_sides': instance.teamSides.map((e) => e.toJson()).toList(),
      'tg_list': instance.tgList.map((e) => e.toJson()).toList(),
      'finance_details': instance.financeDetails.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
