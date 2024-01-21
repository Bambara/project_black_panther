import 'package:json_annotation/json_annotation.dart';

part 'tournament_organizer.g.dart';

@JsonSerializable(explicitToJson: true)
class TournamentOrganizer {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'organization_id')
  String organizationId;

  String type;
  String role;
  String status;

  TournamentOrganizer(this.id, this.organizationId, this.type, this.role, this.status);

  factory TournamentOrganizer.fromJson(Map<String, dynamic> json) => _$TournamentOrganizerFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentOrganizerToJson(this);
}
