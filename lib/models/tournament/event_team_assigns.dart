import 'package:json_annotation/json_annotation.dart';

import 'event_team_assign.dart';

part 'event_team_assigns.g.dart';

@JsonSerializable(explicitToJson: true)
class EventTeamAssigns {
  List<EventTeamAssign> assignTeams;

  EventTeamAssigns(this.assignTeams);

  factory EventTeamAssigns.fromJson(Map<String, dynamic> json) => _$EventTeamAssignsFromJson(json);

  Map<String, dynamic> toJson() => _$EventTeamAssignsToJson(this);
}
