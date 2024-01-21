import 'package:json_annotation/json_annotation.dart';

part 'match_award.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchAward {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'award_id')
  String awardId;

  @JsonKey(name: 'winner_id')
  String winnerId;

  @JsonKey(name: 'winner_type')
  String winnerType;

  MatchAward(this.id, this.awardId, this.winnerId, this.winnerType);

  factory MatchAward.fromJson(Map<String, dynamic> json) => _$MatchAwardFromJson(json);

  Map<String, dynamic> toJson() => _$MatchAwardToJson(this);
}
