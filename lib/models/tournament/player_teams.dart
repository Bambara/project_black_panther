import 'package:json_annotation/json_annotation.dart';

import 'player_team.dart';

part 'player_teams.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerTeams {
  @JsonKey(name: 'player_teams')
  List<PlayerTeam> playerTeams;

  PlayerTeams(this.playerTeams);

  factory PlayerTeams.fromJson(Map<String, dynamic> json) => _$PlayerTeamsFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerTeamsToJson(this);
}
