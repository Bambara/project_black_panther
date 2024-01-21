import 'package:json_annotation/json_annotation.dart';

import 'match_place.dart';
import 'match_result.dart';

part 'event_match.g.dart';

@JsonSerializable(explicitToJson: true)
class EventMatch {
  @JsonKey(name: '_id')
  String id;

  String name;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'start_time')
  String startTime;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'end_time')
  String endTime;

  String status;

  @JsonKey(name: 'te_id')
  String teId;

  @JsonKey(name: 'tournament_id')
  String tournamentId;

  @JsonKey(name: 'match_place')
  MatchPlace matchPlace;

  @JsonKey(name: 'match_results')
  MatchResult matchResults;

  String createdAt;
  String updatedAt;

  EventMatch(
    this.id,
    this.name,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.status,
    this.teId,
    this.tournamentId,
    this.matchPlace,
    this.matchResults,
    this.createdAt,
    this.updatedAt,
  );

  factory EventMatch.fromJson(Map<String, dynamic> json) => _$EventMatchFromJson(json);

  Map<String, dynamic> toJson() => _$EventMatchToJson(this);
}
