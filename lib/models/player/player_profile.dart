import 'package:json_annotation/json_annotation.dart';

import '../common/avatar.dart';
import 'player_game_list.dart';
import 'player_sponsor_list.dart';

part 'player_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerProfile {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'default_ign')
  String defaultIgn;

  Avatar avatar;

  @JsonKey(name: 'club_id')
  String clubId;

  @JsonKey(name: 'clan_id')
  String clanId;

  @JsonKey(name: 'local_rank')
  double localRank;

  @JsonKey(name: 'global_rank')
  double globalRank;

  @JsonKey(name: 'win_rate')
  double winRate;

  @JsonKey(name: 'toxic_level')
  double toxicLevel;

  @JsonKey(name: 'discipline_level')
  double disciplineLevel;

  @JsonKey(name: 'skill_level')
  double skillLevel;

  @JsonKey(name: 'report_count')
  double reportCount;

  @JsonKey(name: 'game_list')
  List<PlayerGameList> gameList;

  @JsonKey(name: 'sponsor_list')
  List<PlayerSponsorList> sponsorList;

  String status;

  @JsonKey(name: 'user_id')
  String userId;

  String createdAt;
  String updatedAt;

  PlayerProfile(
    this.id,
    this.defaultIgn,
    this.avatar,
    this.clubId,
    this.clanId,
    this.localRank,
    this.globalRank,
    this.winRate,
    this.toxicLevel,
    this.disciplineLevel,
    this.skillLevel,
    this.reportCount,
    this.gameList,
    this.sponsorList,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory PlayerProfile.fromJson(Map<String, dynamic> json) => _$PlayerProfileFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerProfileToJson(this);
}
