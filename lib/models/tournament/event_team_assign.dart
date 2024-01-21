import 'package:json_annotation/json_annotation.dart';

part 'event_team_assign.g.dart';

@JsonSerializable(explicitToJson: true)
class EventTeamAssign {
  @JsonKey(name: '_id')
  String id;

  String status;

  @JsonKey(name: 'card_color')
  String cardColor;

  @JsonKey(name: 'ptl_id')
  String ptlId;

  @JsonKey(name: 'te_id')
  String teId;

  String createdAt;

  String updatedAt;

  EventTeamAssign(
    this.id,
    this.status,
    this.cardColor,
    this.ptlId,
    this.teId,
    this.createdAt,
    this.updatedAt,
  );

  factory EventTeamAssign.fromJson(Map<String, dynamic> json) => _$EventTeamAssignFromJson(json);

  Map<String, dynamic> toJson() => _$EventTeamAssignToJson(this);
}
