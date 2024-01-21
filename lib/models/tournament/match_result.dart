import 'package:json_annotation/json_annotation.dart';

import 'match_award.dart';
import 'win_team.dart';

part 'match_result.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchResult {
  // @JsonKey(name: '_id')
  // String id;

  @JsonKey(name: 'win_teams')
  List<WinTeam> winTeams;

  List<MatchAward> awards;

  MatchResult(this.winTeams, this.awards);

  factory MatchResult.fromJson(Map<String, dynamic> json) => _$MatchResultFromJson(json);

  Map<String, dynamic> toJson() => _$MatchResultToJson(this);
}
