import 'package:json_annotation/json_annotation.dart';

part 'player_performance_result.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerPerformanceResult {
  // @JsonKey(name: '_id')
  // String id;

  @JsonKey(name: 'match_count')
  double matchCount;

  @JsonKey(name: 'win_count')
  double winCount;

  @JsonKey(name: 'toxic_level')
  double toxicLevel;

  @JsonKey(name: 'average_damage')
  double averageDamage;

  @JsonKey(name: 'average_skill')
  double averageSkill;

  @JsonKey(name: 'mvp_count')
  double mvpCount;

  String remark;

  PlayerPerformanceResult(this.matchCount, this.winCount, this.toxicLevel, this.averageDamage, this.averageSkill, this.mvpCount, this.remark);

  factory PlayerPerformanceResult.fromJson(Map<String, dynamic> json) => _$PlayerPerformanceResultFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerPerformanceResultToJson(this);
}
