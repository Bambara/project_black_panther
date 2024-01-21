import 'package:json_annotation/json_annotation.dart';

part 'win_team.g.dart';

@JsonSerializable(explicitToJson: true)
class WinTeam {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'match_team_id')
  String matchTeamId;

  String place;

  WinTeam(this.id, this.matchTeamId, this.place);

  factory WinTeam.fromJson(Map<String, dynamic> json) => _$WinTeamFromJson(json);

  Map<String, dynamic> toJson() => _$WinTeamToJson(this);
}
