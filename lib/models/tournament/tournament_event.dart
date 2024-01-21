import 'package:json_annotation/json_annotation.dart';
import 'package:project_black_panther/models/common/art_work.dart';

part 'tournament_event.g.dart';

@JsonSerializable()
class TournamentEvent {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'event_name')
  String eventName;

  @JsonKey(name: 'event_type')
  String eventType;

  @JsonKey(name: 'team_type')
  String teamType;

  @JsonKey(name: 'art_works')
  List<ArtWork> artWorks;

  String status;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'tournament_id')
  String tournamentId;

  String createdAt;
  String updatedAt;

  TournamentEvent(this.id, this.eventName, this.eventType, this.teamType, this.artWorks, this.status, this.gameId, this.tournamentId, this.createdAt, this.updatedAt);

  factory TournamentEvent.fromJson(Map<String, dynamic> json) => _$TournamentEventFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentEventToJson(this);
}
