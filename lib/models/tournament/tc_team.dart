import 'package:json_annotation/json_annotation.dart';
import 'package:project_black_panther/models/common/avatar.dart';
import 'package:project_black_panther/models/tournament/tc_team_member.dart';

part 'tc_team.g.dart';

//TCTeam - Tournament Coordinate Teams
@JsonSerializable(explicitToJson: true)
class TCTeam {
  @JsonKey(name: '_id')
  String id;

  String code;
  String name;
  Avatar avatar;
  String role;
  String status;
  List<TCTeamMember> members;

  TCTeam(this.id, this.code, this.name, this.avatar, this.role, this.status, this.members);

  factory TCTeam.fromJson(Map<String, dynamic> json) => _$TCTeamFromJson(json);

  Map<String, dynamic> toJson() => _$TCTeamToJson(this);
}
