import 'package:json_annotation/json_annotation.dart';
import 'package:project_black_panther/models/common/avatar.dart';

import 'pt_member.dart';

part 'player_team.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerTeam {
  @JsonKey(name: '_id')
  String id;

  String name;
  String code;
  Avatar logo;

  @JsonKey(name: 'team_type')
  String teamType;

  @JsonKey(name: 'clan_id')
  String clanId;

  @JsonKey(name: 'club_id')
  String clubId;

  List<PTMember> members;
  String status;

  @JsonKey(name: 'tournament_id')
  String tournamentId;

  PlayerTeam(this.id, this.name, this.code, this.logo, this.teamType, this.clanId, this.clubId, this.members, this.status, this.tournamentId);

  factory PlayerTeam.fromJson(Map<String, dynamic> json) => _$PlayerTeamFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerTeamToJson(this);
}
