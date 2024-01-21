// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) => PlayerProfile(
      json['_id'] as String,
      json['default_ign'] as String,
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      json['club_id'] as String,
      json['clan_id'] as String,
      (json['local_rank'] as num).toDouble(),
      (json['global_rank'] as num).toDouble(),
      (json['win_rate'] as num).toDouble(),
      (json['toxic_level'] as num).toDouble(),
      (json['discipline_level'] as num).toDouble(),
      (json['skill_level'] as num).toDouble(),
      (json['report_count'] as num).toDouble(),
      (json['game_list'] as List<dynamic>).map((e) => PlayerGameList.fromJson(e as Map<String, dynamic>)).toList(),
      (json['sponsor_list'] as List<dynamic>).map((e) => PlayerSponsorList.fromJson(e as Map<String, dynamic>)).toList(),
      json['status'] as String,
      json['user_id'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$PlayerProfileToJson(PlayerProfile instance) => <String, dynamic>{
      '_id': instance.id,
      'default_ign': instance.defaultIgn,
      'avatar': instance.avatar.toJson(),
      'club_id': instance.clubId,
      'clan_id': instance.clanId,
      'local_rank': instance.localRank,
      'global_rank': instance.globalRank,
      'win_rate': instance.winRate,
      'toxic_level': instance.toxicLevel,
      'discipline_level': instance.disciplineLevel,
      'skill_level': instance.skillLevel,
      'report_count': instance.reportCount,
      'game_list': instance.gameList.map((e) => e.toJson()).toList(),
      'sponsor_list': instance.sponsorList.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'user_id': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
